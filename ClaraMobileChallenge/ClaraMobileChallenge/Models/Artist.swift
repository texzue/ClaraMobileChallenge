//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct Artist: Codable, Identifiable {
    let aliases: [Alias]?
    let dataQuality: String?
    let id: Int
    let images: [ArtistImage]?
    let members: [Member]?
    let message: String?
    let namevariations: [String]?
    let profile: String? // Band description
    private let releasesUrl: String?
    private let resourceUrl: String?
    private let uri: String?
    private let urls: [String]?
}

extension Artist {
    struct Member: Codable, Identifiable {
        let active: Bool?
        let id: Int?
        let name: String?
        let resourceUrl: String?
    }

    struct ArtistImage: Codable {
        let height: Int?
        let resourceURL: String?
        let type: String?
        let uri: String?
        let uri150: String?
        let width: Int?
    }

    struct Alias: Codable, Identifiable {
        let id: Int
        let name: String?
        let resourceUrl: URL?
    }
}

extension Artist {
    private func getURL(_ uri: String) -> URL? {
        let pictureURL = uri.replacingOccurrences(of: "\"", with: "")
        return URL(string: pictureURL)
    }
    
    var uriURL: URL? {
        guard let url = self.uri else { return nil }
        return getURL(url)
    }

    var networks: [URL]? {
        guard let urls = self.urls else { return nil }
        return urls.reduce([URL]()) { current, next in
            current + [self.getURL(next)!]
        }
    }

    var discogsResourceURL: URL? {
        guard let url = self.resourceUrl else { return nil }
        return getURL(url)
    }

    var discogsReleasesURL: URL? {
        guard let url = self.releasesUrl else { return nil }
        return getURL(url)
    }
}
