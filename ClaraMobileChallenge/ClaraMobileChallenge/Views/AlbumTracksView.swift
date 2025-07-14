//
//  AlbumTracksView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import SwiftUI

struct AlbumTracksView: View {

    @EnvironmentObject var vmAlbumTracks: AlbumTracksViewModel
    @Binding var albumId: Int?

    var body: some View {
        Form {
            Section {
                RowView(title: "Album", subtitle: vmAlbumTracks.albumDetails?.title ?? "")
                RowView(title: "Companies", subtitle: vmAlbumTracks.albumDetails?.companies ?? "")
                RowView(title: "Genres", subtitle: vmAlbumTracks.albumDetails?.genres ?? "")
                RowView(title: "Year", subtitle: vmAlbumTracks.albumDetails?.year ?? "")
                RowView(title: "Description", subtitle: vmAlbumTracks.albumDetails?.desciption ?? "", isVertical: true, smallDescription: true)
            } header: {
                Text("Details")
            }
            Section {
                ForEach(vmAlbumTracks.albumDetails?.traks ?? []) { track in
                    Text(track.name)
                }
            } header: {
                Text("Tracks")
            }
        }
        .background(.contentBackground)
        .onAppear {
            if let albumId {
                vmAlbumTracks.performAction(.getAlbumDetails(albumId))
            }
        }
        .overlay {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
                .opacity(vmAlbumTracks.loading ? 1 : 0)
        }
    }
}

#Preview {
    AlbumTracksView(albumId: .constant(1))
        .environmentObject(
            AlbumTracksViewModel(releasesInteractor: PreviewReleasesInteractor(returnErrorEnabled: false, networkErrorToReturn: .accessDenied))
        )
}
