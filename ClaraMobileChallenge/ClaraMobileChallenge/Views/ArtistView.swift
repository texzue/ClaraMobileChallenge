//
//  ArtistView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI

struct ArtistView: View {

    let artist: Artist
    let releases: Releases

    var body: some View {
        Form {
            Section {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(.constant(artist.images ?? []), id:\.self) { image in
                            Image(.test)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }.padding(.vertical, 1.su)
                }
            } header: {
                Text("Covers")
            }
        }
        .navigationTitle(artist.name.viewLabel)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ArtistView(artist: Artist.demo!, releases: Releases.demo!)
    }
}
