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
                List(searchContentViewModel.results) { result in
                    NavigationLink(destination: ArtistDetailsView(searchResult: result)) {
                        ScoreCell(
                            title: result.title.viewLabel,
                            subtitle: result.type.viewLabel.capitalized,
                            imageURL: result.thumbURL
                        )
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
    var searchResult: Search.Results

    var body: some View {
        Text(searchResult.title.viewLabel)
    }
}
