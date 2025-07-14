//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct PaginationDTO: Codable {
    let page: Int?
    let pages: Int?
    let perPage: Int?
    let items: Int?
    let urls: PaginationURLs?
}

struct PaginationURLs: Codable {
    let last: String?
    let next: String?
}
