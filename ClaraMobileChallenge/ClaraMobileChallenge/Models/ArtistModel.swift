//
//  ArtisModel.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import Foundation
import UIKit

struct ArtistModel: ViewModel, Identifiable {
    private let artistDTO: ArtistDTO

    init(artist: ArtistDTO) {
        self.artistDTO = artist
    }

    // MARK:  Computed Properties

    var artistName: String {
        artistDTO.name ?? "NA"
    }

    var artistNameVariations: String {
        artistDTO.namevariations?.formatted(.list(type: .and)) ?? "NA"
    }

    var artistProfile: String {
        artistDTO.profile ?? "NA"
    }

    var artistUri: URL? {
        getURL(artistDTO.uri)
    }

    var id: String {
        String(artistDTO.id)
    }

    var artistImages: [URL] {
        artistDTO.images?.compactMap { artistImage in
            getURL(artistImage.resourceURL)
        } ?? []
    }

    var members: [String] {
        artistDTO.members?.compactMap(\.name) ?? []
    }
}
