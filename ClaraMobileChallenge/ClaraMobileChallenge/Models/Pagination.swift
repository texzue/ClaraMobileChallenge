//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct Pagination: Codable {
    let page: Int?
    let pages: Int?
    let perPage: Int?
    let items: Int?
    let urls: PaginationURLs?
}

struct PaginationURLs: Codable {
    private let last: String?
    private let next: String?
}

extension PaginationURLs {
    private func getURL(_ uri: String) -> URL? {
        let pictureURL = uri.replacingOccurrences(of: "\"", with: "")
        return URL(string: pictureURL)
    }

    var lastURL: URL? {
        guard let url = last else { return nil }
        return getURL(url)
    }

    var nextURL: URL? {
        guard let url = next else { return nil }
        return getURL(url)
    }
}
