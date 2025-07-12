//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct Search: Codable {
    let pagination: Pagination?
    let results: [Results]?
    let message: String?
}

extension Search {
    struct Results: Codable, Identifiable {
        let style: [String]?
        private let thumb: String?
        let title: String?
        let country: String?
        let format: [String]?
        private let uri: String?
        let community: Community?
        let label: [String]?
        let catno: String?
        let resourceUrl: String?
        let type: String?
        let id: Int
        let masterId: String?
        private let masterUrl: String?
        let coverImage: String?
    }

    struct Community: Codable {
        let have: Int?
        let want: Int?
    }
}

extension Search.Results {
    private func getURL(_ uri: String) -> URL? {
        let pictureURL = uri.replacingOccurrences(of: "\"", with: "")
        return URL(string: pictureURL)
    }

    var resource: URL? {
        guard let url = self.resourceUrl else { return nil }
        return getURL(url)
    }

    var thumbURL: URL? {
        guard let url = self.thumb else { return nil }
        return getURL(url)
    }

    var uriURL: URL? {
        guard let url = self.uri else { return nil }
        return getURL(url)
    }
}
