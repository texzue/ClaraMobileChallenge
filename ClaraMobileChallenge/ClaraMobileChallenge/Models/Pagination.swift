//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import Foundation


struct Pagination: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let items: Int
    let urls: PaginationURLs

    enum CodingKeys: String, CodingKey {
        case page, pages, items, urls
        case perPage = "per_page"
    }
}


// MARK: - Pagination URLs Struct

struct PaginationURLs: Codable {
    let last: String?
    let next: String?
}
