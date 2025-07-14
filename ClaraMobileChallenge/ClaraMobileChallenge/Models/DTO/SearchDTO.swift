//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct SearchDTO: Codable {
    let pagination: PaginationDTO?
    let results: [Results]?
    let message: String?
}

extension SearchDTO {
    struct Results: Codable, Identifiable {
        let style: [String]?
        let thumb: String?
        let title: String?
        let country: String?
        let format: [String]?
        let uri: String?
        let community: Community?
        let label: [String]?
        let catno: String?
        let resourceUrl: String?
        let type: String?
        let id: Int
        let masterId: String?
        let masterUrl: String?
    }

    struct Community: Codable {
        let have: Int?
        let want: Int?
    }
}

extension SearchDTO.Results {
    static var test: Self? {
        let search: SearchDTO? = try? BundleFileManager.loadDataFromFile(from: "preview_main_search")
        return search?.results?.first
    }
}
