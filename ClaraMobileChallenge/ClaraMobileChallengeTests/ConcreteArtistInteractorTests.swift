//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import XCTest
@testable import ClaraMobileChallenge

final class ConcreteArtistInteractorTests: XCTestCase {

    func testMainSearchParsing() async throws {
        let sut = ConcreteArtistInteractor(networkInteractor: PreviewNetworkInteractor(fileName: "preview_main_search", timeOutInterval: 0))
        let result = try await sut.searchArtist(artist: "foo", page: 1)
        if case let .success(search) = result {
            XCTAssertEqual(search.pagination?.items, 4)
            XCTAssertEqual(search.pagination?.page, 1)
            XCTAssertEqual(search.pagination?.pages, 1)
            XCTAssertEqual(search.pagination?.perPage, 30)
            XCTAssertNotNil(search.pagination?.urls?.last)
            XCTAssertNotNil(search.pagination?.urls?.next)
            XCTAssertNil(search.message)

            let firstResult = search.results?.first
            XCTAssertEqual(search.results?.count, 4)
            XCTAssertNil(firstResult?.catno)
            XCTAssertNil(firstResult?.community?.want)
            XCTAssertNil(firstResult?.community?.have)
            XCTAssertEqual(firstResult?.country, "Canada")
            XCTAssertNil(firstResult?.masterId)
            XCTAssertNotNil(firstResult?.resourceUrl)
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

    func testGetArtistDetailsParsing() async throws {
        let sut = ConcreteArtistInteractor(networkInteractor: PreviewNetworkInteractor(fileName: "preview_get_artist", timeOutInterval: 0))
        let result = try await sut.getArtistDetails(with: 1)

        if case let .success(artist) = result {
            XCTAssertNil(artist.aliases?.count)
            XCTAssertEqual(artist.dataQuality, "Needs Vote")
            XCTAssertEqual(artist.id, 326404)
            XCTAssertEqual(artist.images?.count, 6)
            XCTAssertEqual(artist.members?.count, 8)
            XCTAssertEqual(artist.members?.first?.name, "Aaron Gillespie")
            XCTAssertNil(artist.message)
            XCTAssertEqual(artist.namevariations?.count, 1)
            XCTAssertEqual(artist.namevariations?.first, "Underøath")
            XCTAssertEqual(artist.profile?.count, 740)
            XCTAssertEqual(artist.uri, "https://www.discogs.com/artist/326404-Underoath")
            XCTAssertEqual(artist.urls?.count, 8)
            XCTAssertEqual(artist.urls?.first, "http://www.underoath777.com")
            XCTAssertEqual(artist.resourceUrl, "https://api.discogs.com/artists/326404")
            XCTAssertEqual(artist.releasesUrl, "https://api.discogs.com/artists/326404/releases")
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

    func testGetArtistReleasesDetailsParsing() async throws {
        let sut = ConcreteArtistInteractor(networkInteractor: PreviewNetworkInteractor(fileName: "preview_get_releases", timeOutInterval: 0))
        let result = try await sut.getArtistReleases(artistId: 1, page: 1)

        if case let .success(artistReleases) = result {
            XCTAssertNil(artistReleases.message)
            XCTAssertNotNil(artistReleases.pagination)
            XCTAssertEqual(artistReleases.pagination?.urls?.last, "https://api.discogs.com/artists/326404/releases?sort_order=asc&page=8&sort=year&per_page=30")
            XCTAssertEqual(artistReleases.pagination?.urls?.next, "https://api.discogs.com/artists/326404/releases?sort_order=asc&page=2&sort=year&per_page=30")

            let firstRelease = artistReleases.releases?.first
            XCTAssertEqual(artistReleases.releases?.count, 6)
            XCTAssertEqual(firstRelease?.artist, "Underoath")
            XCTAssertEqual(firstRelease?.id, 30835803)
            XCTAssertNil(firstRelease?.mainRelease)
            XCTAssertEqual(firstRelease?.role, "Main")
            XCTAssertEqual(firstRelease?.thumb, "https://i.discogs.com/wfLvmAj3er8_Zdg-jJnmdzC-XxtMQZ04h6kuIZKIE-8/rs:fit/g:sm/q:40/h:150/w:150/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTMwODM1/ODAzLTE3MjUwMzkz/NzgtNzU1OC5qcGVn.jpeg")
            XCTAssertEqual(firstRelease?.title, "A Love So Pure")
            XCTAssertEqual(firstRelease?.type, "release")
            XCTAssertEqual(firstRelease?.year, 1998)
            XCTAssertEqual(firstRelease?.format, "CDr, Album")
            XCTAssertEqual(firstRelease?.label, "Not On Label (Underoath Self-released)")
            XCTAssertEqual(firstRelease?.status, "Accepted")
            XCTAssertEqual(firstRelease?.stats?.community?.inCollection, 1)
            XCTAssertEqual(firstRelease?.stats?.community?.inWantlist, 87)
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
