//
//  Release.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import Foundation

struct ReleaseModel: ViewModel, Identifiable {
    private let releaseDTO: ReleasesDTO.Release

    init(release: ReleasesDTO.Release) {
        self.releaseDTO = release
        if let pictureURL = release.thumb?.replacingOccurrences(of: "\"", with: "") {
            thumbnail = URL(string: pictureURL)
        }
    }

    // MARK: Computed Properties

    var id: Int {
        releaseDTO.id
    }

    var mainReleaseID: Int {
        releaseDTO.mainRelease ?? releaseDTO.id
    }

    var title: String {
        releaseDTO.title ?? "NA"
    }

    var thumbnail: URL?

    var releaseYear: String {
        String(releaseDTO.year ?? 0)
    }
}
