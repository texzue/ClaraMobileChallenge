//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var artistName: String = "https://api.discogs.com/database/"
    
    var body: some View {
        
        LazyVStack(alignment: .leading, spacing: 1.su) {
            Button("Autenticate") {
                authenticate()
            }
            
            TextField("Artist Name", text: $artistName)
                .textFieldStyle(.roundedBorder)
            
            Button("Get Nirvana") {
                getArtist()
            }
            
            Button("Search artist") {
                getArtistDetails()
            }
        }.padding(.horizontal, 2.su)
        
    }

    private func addItem() {
        withAnimation {
            authenticate()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            authenticate()
        }
    }
    
    private func authenticate() {
        Task {
            do {
                let result = try await OauthAuthenticator.shared.autenticate()
                switch result {
                case .success:
                    print()
                case .failure(let error):
                    handleError(error)
                }
            }
        }
    }
    
    private func getArtist() {
        Task {
            do {
                let result = try await EndpointCaller.shared.getArtistsAsync()
                switch result {
                case .success(let artists):
                    print(artists)
                case .failure(let error):
                    handleError(error)
                }
            }
        }
    }
    
    private func getArtistDetails() {
        Task {
            do {
                let result = try await EndpointCaller.shared.getArtistDetails(artist: artistName)
                switch result {
                case .success(let artists):
                    print(artists)
                case .failure(let error):
                    handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: OAuthError) {
        switch error {
        case .invalidURL:
            print("Invalid URL")
        case .invalidAuthentication:
            Task {
                try await OauthAuthenticator.shared.autenticate()
            }
        case .invalidData:
            print("Invalid Data")
        case .invalidResponse(let error):
            print("Invalid Response \(error)")
        case .emptyData:
            print("Empty Data")
        }
    }
}

#Preview {
    ContentView()
}
