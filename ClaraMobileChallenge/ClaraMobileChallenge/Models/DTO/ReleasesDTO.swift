//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct ReleasesDTO: Codable {
    let pagination: PaginationDTO?
    let releases: [Release]?
    let message: String?
}

extension ReleasesDTO {
    struct Release: Codable, Identifiable {
        let artist: String?
        let id: Int
        let mainRelease: Int?
        let resourceUrl: String?
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

extension ReleasesDTO {
    static var test: Self? {
        try? BundleFileManager.loadDataFromFile(from: "preview_get_releases")
    }
}
