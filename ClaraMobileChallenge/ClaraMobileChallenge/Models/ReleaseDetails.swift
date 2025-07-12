//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

struct ReleaseDetails: Codable {
    let title: String?
    let id: Int?
    let artists: [Artist]?
    let dataQuality: String?
    let thumb: String? // thumb
    let community: Community?
    let companies: [Company]?
    let country: String?
    private let dateAdded: String? // 2004-04-30T08:10:05-07:00
    private let dateChanged: String? // 2004-04-30T08:10:05-07:00
    let estimatedWeight: Int?
    let extraartists: [ExtraArtist]?
    let formatQuantity: Int?
    let formats: [Format]?
    let genres: [String]?
    let identifiers: [Identifier]?
    let images: [Image]?
    let labels: [Label]?
    let lowestPrice: Double?
    let masterID: Int?
    let masterURL: String? // URL
    let notes: String?
    let numForSale: Int?
    let released: String?
    let releasedFormatted: String?
    let resourceURL: String? // URL
    let series: [String]?
    let status: String?
    let styles: [String]?
    let tracklist: [Track]?
    let uri: String? // URL
    let videos: [Video]?
    let year: Int?
}

extension ReleaseDetails {
    var lastDateAdded: Date? {
        guard let dateAdded else { return nil }
        return date(from: dateAdded)
    }

    var lastDateChanged: Date? {
        guard let dateChanged else { return nil }
        return date(from: dateChanged)
    }

    private func date(from iso8601String: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: iso8601String)
    }
}

extension ReleaseDetails {
    struct Artist: Codable {
        let anv: String?
        let id: Int?
        let join: String?
        let name: String?
        let resourceURL: String? // URL
        let role: String?
        let tracks: String?
    }

    struct Community: Codable {
        let contributors: [Contributor]?
        let dataQuality: String?
        let have: Int?
        let rating: Rating?
        let status: String?
        let submitter: Submitter?
        let want: Int?
    }

    struct Contributor: Codable {
        let resourceURL: URL?
        let username: String?
    }

    struct Rating: Codable {
        let average: Double?
        let count: Int?
    }

    struct Submitter: Codable {
        let resourceURL: URL?
        let username: String?
    }

    struct Company: Codable {
        let catno: String?
        let entityType: String?
        let entityTypeName: String?
        let id: Int?
        let name: String?
        let resourceURL: URL?
    }

    struct ExtraArtist: Codable {
        let anv: String?
        let id: Int?
        let join: String?
        let name: String?
        let resourceURL: URL?
        let role: String?
        let tracks: String?
    }

    struct Format: Codable {
        let descriptions: [String]?
        let name: String?
        let qty: String?
    }

    struct Identifier: Codable {
        let type: String?
        let value: String?
    }

    struct Image: Codable {
        let height: Int?
        let resourceURL: URL?
        let type: String?
        let uri: URL?
        let uri150: URL?
        let width: Int?
    }

    struct Label: Codable {
        let catno: String?
        let entityType: String?
        let id: Int?
        let name: String?
        let resourceURL: URL?
    }

    struct Track: Codable {
        let duration: String?
        let position: String?
        let title: String?
        let type: String?
    }

    struct Video: Codable {
        let description: String?
        let duration: Int?
        let embed: Bool?
        let title: String?
        let uri: String? // URL
    }
}
