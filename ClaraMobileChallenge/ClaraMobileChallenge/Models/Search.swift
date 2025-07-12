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
        let thumb: String?
        let title: String?
        let country: String?
        let format: [String]?
        let uri: URL?
        let community: Community?
        let label: [String]?
        let catno: String?
        let resourceUrl: String?
        let type: String?
        let id: Int
        let masterId: String?
        let masterUrl: String?
        let coverImage: String?
    }

    struct Community: Codable {
        let have: Int?
        let want: Int?
    }
}
