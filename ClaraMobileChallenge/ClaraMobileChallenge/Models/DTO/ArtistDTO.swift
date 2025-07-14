//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct ArtistDTO: Codable, Identifiable {
    let aliases: [Alias]?
    let dataQuality: String?
    let id: Int
    let images: [ArtistImage]?
    let members: [Member]?
    let message: String?
    let name: String?
    let namevariations: [String]?
    let profile: String? // Band description
    let releasesUrl: String?
    let resourceUrl: String?
    let uri: String?
    let urls: [String]?
}

extension ArtistDTO {
    struct Member: Codable, Identifiable {
        let active: Bool?
        let id: Int?
        let name: String?
        let resourceUrl: String?
    }

    struct ArtistImage: Codable, Hashable {
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

extension ArtistDTO {
    static var test: Self? {
        try? BundleFileManager.loadDataFromFile(from: "preview_get_artist")
    }
}
