//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import XCTest
@testable import ClaraMobileChallenge

final class ConcreteReleasesInteractorTests: XCTestCase {

    func testDecodable() async throws {
        let sut = ConcreteReleasesInteractor(networkInteractor: PreviewNetworkInteractor(fileName: "preview_get_release_details", timeOutInterval: 0))
        let result = try await sut.getReleaseDetails(with: 1)

        if case let .success(releaseDetails) = result {
            XCTAssertNotNil(releaseDetails)
        } else if case let .failure(error) = result {
            switch error {
            case .general(let specificError):
                debugPrint(specificError)
            default:
                print(error.localizedDescription)
            }
            throw error
        }
    }

    func testGetReleaseDetailsParsing() async throws {
        let sut = ConcreteReleasesInteractor(networkInteractor: PreviewNetworkInteractor(fileName: "preview_get_release_details", timeOutInterval: 0))
        let result = try await sut.getReleaseDetails(with: 1)

        if case let .success(releaseDetails) = result {
            XCTAssertEqual(releaseDetails.title, "Never Gonna Give You Up")
            XCTAssertEqual(releaseDetails.id, 249504)
            XCTAssertEqual(releaseDetails.artists?.count, 1)
            XCTAssertEqual(releaseDetails.dataQuality, "Correct")
            XCTAssertEqual(releaseDetails.thumb, "https://api-img.discogs.com/kAXVhuZuh_uat5NNr50zMjN7lho=/fit-in/300x300/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-249504-1334592212.jpeg.jpg")
            XCTAssertEqual(releaseDetails.community?.rating?.average, 3.42)
            XCTAssertEqual(releaseDetails.companies?.count, 2)
            XCTAssertEqual(releaseDetails.country, "UK")
            XCTAssertNotNil(releaseDetails.dateAdded)
            XCTAssertNotNil(releaseDetails.dateChanged)
            XCTAssertEqual(releaseDetails.estimatedWeight, 60)
            XCTAssertEqual(releaseDetails.extraartists?.count, 2)
            XCTAssertEqual(releaseDetails.formatQuantity, 1)
            XCTAssertEqual(releaseDetails.formats?.count, 1)
            XCTAssertEqual(releaseDetails.genres?.count, 2)
            XCTAssertEqual(releaseDetails.identifiers?.count, 1)
            XCTAssertEqual(releaseDetails.images?.count, 2)
            XCTAssertEqual(releaseDetails.labels?.count, 1)
            XCTAssertEqual(releaseDetails.lowestPrice, 0.63)
            XCTAssertNil(releaseDetails.masterID)
            XCTAssertNil(releaseDetails.masterURL)
            XCTAssertNotNil(releaseDetails.notes)
            XCTAssertEqual(releaseDetails.numForSale, 58)
            XCTAssertEqual(releaseDetails.released, "1987")
            XCTAssertEqual(releaseDetails.releasedFormatted, "1987")
            XCTAssertNil(releaseDetails.resourceURL)
            XCTAssertEqual(releaseDetails.series?.count, 0)
            XCTAssertEqual(releaseDetails.status, "Accepted")
            XCTAssertEqual(releaseDetails.styles?.count, 1)
            XCTAssertEqual(releaseDetails.tracklist?.count, 2)
            XCTAssertEqual(releaseDetails.tracklist?.first?.title, "Never Gonna Give You Up")
            XCTAssertEqual(releaseDetails.uri, "https://www.discogs.com/Rick-Astley-Never-Gonna-Give-You-Up/release/249504")
            XCTAssertEqual(releaseDetails.videos?.count, 1)
            XCTAssertEqual(releaseDetails.year, 1987)




        } else if case let .failure(error) = result {
            switch error {
            case .general(let specificError):
                debugPrint(specificError)
            default:
                print(error.localizedDescription)
            }
            throw error
        }
    }
}
