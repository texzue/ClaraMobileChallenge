//
//  ArtistView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI
import UIKit

struct ArtistView: View {

    @EnvironmentObject var vmArtistDetails: ArtistDetailsViewModel
    var selectedArtist: SearchItemModel
    @State var presentAllAlbums: Bool = false

    var body: some View {
        Form {
            Section {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(vmArtistDetails.artistImages, id: \.self) { artistImage in
                            if let image = vmArtistDetails.getLocalImage(artistImage){
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 140, height: 140, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 2)
                            } else {
                                AsyncImage(url: artistImage) { image in
                                    image.image?.resizable().aspectRatio(contentMode: .fill).clipped()
                                }
                                .frame(width: 140, height: 140, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 2)
                            }
                        }
                    }.padding(.vertical, 1.su)
                }
            } header: {
                Text("Covers")
            }
            Section {
                RowView(title: "Artist", subtitle: vmArtistDetails.artistDetails?.artistName ?? "")
                RowView(title: "Name Variations", subtitle: vmArtistDetails.artistDetails?.artistNameVariations ?? "", isVertical: true)
            } header: {
                Text("Main information")
            }
            Section {
                NavigationLink {
                    ArtistAlbumsView(selectedArtist: selectedArtist)
                } label: {
                    Button {
                        presentAllAlbums.toggle()
                    } label: {
                        Text("View all albums").customBoldHeaderStyle()
                    }

                }

            } header: {
                Text("Albums")
            }

            Section {
                RowView(title: "Discogs ID", subtitle: vmArtistDetails.artistDetails?.id ?? "")
                RowView(title: "Profile", subtitle: vmArtistDetails.artistDetails?.artistProfile ?? "", isVertical: true)
            } header: {
                Text("More")
            }
        }
        .background(.contentBackground)
        .navigationTitle(selectedArtist.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            vmArtistDetails.performAction(.loadArtistDetails(selectedArtist.id))
        }
    }
    
}



#Preview {
    NavigationView {
        ArtistView(selectedArtist: SearchItemModel(searchDTO: .test!))
            .environmentObject(
                ArtistDetailsViewModel(artistInteractor: PreviewArtistInteractor(returnErrorEnabled: false, networkErrorToReturn: .noContent),
                                       imageInteractor: PreviewImageInteractor(timeOutInterval: 12))
            )
    }
}
