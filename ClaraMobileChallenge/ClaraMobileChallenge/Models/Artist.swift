//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import Foundation

struct Artist: Codable {
    let country: String?
    let year: String? // Year can sometimes be a string like "Unknown"
    let format: [String]?
    let label: [String]?
    let type: String?
    let genre: [String]?
    let style: [String]?
    let id: Int?
    let barcode: [String]?
    let userData: UserData?
    let masterId: Int?
    let masterUrl: String?
    let uri: String?
    let catno: String?
    let title: String?
    let thumb: String? // Thumbnail image URL
    let coverImage: String? // Full-size cover image URL
    let resourceUrl: String?
    let community: Community?

    enum CodingKeys: String, CodingKey {
        case country, year, format, label, type, genre, style, id, barcode, uri, catno, title, thumb
        case userData = "user_data"
        case masterId = "master_id"
        case masterUrl = "master_url"
        case coverImage = "cover_image"
        case resourceUrl = "resource_url"
        case community
    }
}

// MARK: - User Data Struct

struct UserData: Codable {
    let inWantlist: Bool?
    let inCollection: Bool?

    enum CodingKeys: String, CodingKey {
        case inWantlist = "in_wantlist"
        case inCollection = "in_collection"
    }
}

// MARK: - Community Struct

struct Community: Codable {
    let want: Int?
    let have: Int?
}
