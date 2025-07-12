//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct Releases: Codable {
    let pagination: Pagination?
    let releases: [Release]?
    let message: String?
}

extension Releases {
    struct Release: Codable, Identifiable {
        let artist: String?
        let id: Int
        let mainRelease: Int?
        private let resourceUrl: String?
        let role: String?
        let thumb: String?
        let title: String?
        let type: String? // Album Name
        let year: Int?
        let format: String?
        let label: String? // Company
        let status: String?
        let stats: Stats?
    }

    struct Stats: Codable {
        let community: Community?
    }

    struct Community: Codable {
        let inCollection: Int?
        let inWantlist: Int?
    }
}

extension Releases.Release {
    private func getURL(_ uri: String) -> URL? {
        let pictureURL = uri.replacingOccurrences(of: "\"", with: "")
        return URL(string: pictureURL)
    }

    var resource: URL? {
        guard let url = self.resourceUrl else { return nil }
        return getURL(url)
    }
}
