//
//  ArtistAlbumsView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import SwiftUI
import UIKit

class Object: Identifiable {
    let id: String
    init(_ id: String) { self.id = id }
}

struct ArtistAlbumsView: View {

    @EnvironmentObject var vmArtistDetails: ArtistDetailsViewModel
    var selectedArtist: SearchItemModel
    var imageInteractor: ImageInteractor = ConcreteImageInteractor()

    var loadPreview = false
    @State var lastAlbumIdSelected: Int?
    @State var loadAlbumDetails = false

    var body: some View {
        List {
            ForEach(vmArtistDetails.artistReleases) { item in
                Button {
                    lastAlbumIdSelected = item.mainReleaseID
                    loadAlbumDetails.toggle()
                } label: {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(item.title).customHeaderStyle()
                            Text(item.releaseYear).customContentStyle()
                        }
                        Spacer()
                        CustomAsynkView(url: item.thumbnail, imageInteractor: imageInteractor)
                    }
                }
            }
            if !vmArtistDetails.loading && !vmArtistDetails.noMoreData {
                Text("Loading ...")
                    .customSubHeaderStyle()
                    .onAppear { vmArtistDetails.performAction(.loadNextRecords(selectedArtist.id))
                    }
            }
            if vmArtistDetails.noMoreData {
                Text("No More Albums").font(.caption2.bold())
            }
        }
        .background(.contentBackground)
        .onAppear {
            if loadPreview {
                vmArtistDetails.performAction(.loadNextRecords(selectedArtist.id))
            }
        }
        .sheet(isPresented: $loadAlbumDetails) {
            AlbumTracksView(albumId: $lastAlbumIdSelected)
        }
    }
}

#Preview {
    ArtistAlbumsView(selectedArtist: .init(searchDTO: .test!), loadPreview: true)
        .environmentObject(
            ArtistDetailsViewModel(artistInteractor: PreviewArtistInteractor(returnErrorEnabled: false, networkErrorToReturn: .noContent),
                                   imageInteractor: PreviewImageInteractor(timeOutInterval: 0))
        )
}
