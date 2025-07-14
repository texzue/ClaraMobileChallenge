//
//  ReleaseDetails.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import Foundation

struct ReleaseDetailsModel: ViewModel, Identifiable {
    private let releaseDetailsDTO: ReleaseDetailsDTO

    init(releaseDetailsDTO: ReleaseDetailsDTO) {
        self.releaseDetailsDTO = releaseDetailsDTO
    }

    struct Track: Identifiable {
        let id: Int = UUID().hashValue
        let name: String
        let duration: String
    }

    var title: String {
        releaseDetailsDTO.title ?? "NA"
    }

    var id: Int {
        releaseDetailsDTO.id
    }

    var year: String {
        if let year = releaseDetailsDTO.year {
            return String(year)
        } else {
            return "NA"
        }
    }

    var thumbnail: URL? {
        getURL(releaseDetailsDTO.thumb)
    }

    var companies: String {
        releaseDetailsDTO.companies?.compactMap(\.name).formatted(.list(type: .and)) ?? "NA"
    }

    var releaseCountry: String {
        releaseDetailsDTO.country ?? "NA"
    }

    var genres: String {
        releaseDetailsDTO.genres?.formatted(.list(type: .and)) ?? "NA"
    }

    var labels: String {
        releaseDetailsDTO.labels?.compactMap(\.name).formatted(.list(type: .and)) ?? "NA"
    }

    var desciption: String {
        releaseDetailsDTO.notes ?? "NA"
    }

    var traks: [Track] {
        releaseDetailsDTO.tracklist?.reduce(into: [Track]()) { partialResult, nextTrack in
            guard
                let title = nextTrack.title,
                let duration = nextTrack.duration
            else { return }
            partialResult.append(Track(name: title, duration: duration))
        } ?? []
    }

    var uriURL: URL? {
        guard let uriString = releaseDetailsDTO.uri else { return nil }
        return URL(string: uriString)
    }
}
