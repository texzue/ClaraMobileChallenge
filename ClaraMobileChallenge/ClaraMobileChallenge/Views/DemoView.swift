//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import SwiftUI
import SwiftData

struct DemoView: View {

    let artistInteractor: ArtistInteractor
    let releaseInteractor: ReleasesInteractor
    @State private var artistName: String = ""
    @State private var artistID: String = ""
    @State private var releaseID: String = ""

    var body: some View {
        
        LazyVStack(alignment: .leading, spacing: 1.su) {
            Button("Autenticate") {
                authenticate()
            }

            Text("Search By Artist Name")
                .customHeaderStyle()
            HStack {
                TextField("Artist Name", text: $artistName)
                    .textFieldStyle(.roundedBorder)
                Button("Search") {
                    getArtist()
                }
            }.padding(.bottom, 1.su)

            Text("Artist Details")
                .customHeaderStyle()
            VStack {
                TextField("Artist ID", text: $artistID)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                HStack {
                    Button("Search Artist") {
                        getArtistDetails()
                    }
                    Spacer()
                    Button("Search Releases") {
                        getArtistReleasesDetails()
                    }
                }
            }.padding(.bottom, 1.su)

            Text("Release Details")
                .customHeaderStyle()
            VStack {
                TextField("Release ID", text: $releaseID)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                HStack {
                    Spacer()
                    Button("Search") {
                        getReleasesDetails()
                    }
                }
            }.padding(.bottom, 1.su)


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
                let result = try await artistInteractor.searchArtist(artist: artistName, page: 1)
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
        guard let artistIdAsInt = Int(artistID) else { return }
        Task {
            do {
                let result = try await artistInteractor.getArtistDetails(with: artistIdAsInt)
                switch result {
                case .success(let artist):
                    print(artist)
                case .failure(let error):
                    handleError(error)
                }
            }
        }
    }

    private func getArtistReleasesDetails() {
        guard let artistIdAsInt = Int(artistID) else { return }
        Task {
            do {
                let result = try await artistInteractor.getArtistReleases(artistId: artistIdAsInt, page: 1)
                switch result {
                case .success(let releases):
                    print(releases)
                case .failure(let error):
                    handleError(error)
                }
            }
        }
    }

    private func getReleasesDetails() {
        guard let releaseIdAsInt = Int(releaseID) else { return }
        Task {
            do {
                let result = try await releaseInteractor.getReleaseDetails(with: releaseIdAsInt)
                switch result {
                case .success(let release):
                    print(release)
                case .failure(let error):
                    handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: NetworkError) {
        switch error {
        case .invalidURL:
            print("Invalid URL")
        case .invalidAuthentication:
            Task {
                try await OauthAuthenticator.shared.autenticate()
            }
        case .accessDenied:
            print("Access Denied")
        case .dataCorrupted, .noContent:
            print("Data Corrupted or No Content Error")
        case let .general(error):
            print("General Error: \(error)")
        case .HTTPSResponseError:
            print("HTTP Status Code Error")
        }
    }
}

#Preview {
    DemoView(
        artistInteractor: PreviewArtistInteractor(returnErrorEnabled: false, networkErrorToReturn: .accessDenied),
        releaseInteractor: PreviewReleasesInteractor(returnErrorEnabled: false, networkErrorToReturn: .HTTPSResponseError)
    )
}
