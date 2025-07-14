//
//  SearcherView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI

struct ContentSearcherView: View {

    @EnvironmentObject var searchContentViewModel: SearchContentViewModel
    @State var query: String = ""

    var body: some View {

        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 1.su) {
                    TextField("Type an artist name...", text: $query)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        searchContentViewModel.performAction(.search(query))
                    } label: {
                        Text("Search")
                    }
                    .padding(.leading, 1.su)
                }
                .padding(.horizontal)
                List(searchContentViewModel.results) { record in
                    NavigationLink(destination: ArtistView(selectedArtist: record)) {
                        ScoreCell(title: record.name, subtitle: record.identifier, imageURL: record.thumbnailURL)
                    }
                }
                .overlay {
                    if searchContentViewModel.results.isEmpty {
                        // Search unavailable view
                        EmptyContentView(query: $query)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentSearcherView()
        .environmentObject(
            SearchContentViewModel(
                artistInteractor: PreviewArtistInteractor(returnErrorEnabled: false, networkErrorToReturn: .noContent),
                imageInteractor: PreviewImageInteractor(timeOutInterval: 12))
        )
}

struct ArtistDetailsView: View {
    var searchResult: SearchItemModel

    var body: some View {
        Text(searchResult.name)
    }
}
