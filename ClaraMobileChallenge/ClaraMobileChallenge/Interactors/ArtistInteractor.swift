//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

protocol ArtistInteractor {
    func searchArtist(artist: String, page: Int) async throws -> Result<Search, NetworkError>
    func getArtistDetails(with id: Int) async throws -> Result<Artist, NetworkError>
    func getArtistReleases(artistId: Int, page: Int) async throws -> Result<Releases, NetworkError>
}

final class ConcreteArtistInteractor: ArtistInteractor {

    private let networkInteractor: NetworkInteractor

    init(networkInteractor: NetworkInteractor) {
        self.networkInteractor = networkInteractor
    }

    func searchArtist(artist: String, page: Int) async throws -> Result<Search, NetworkError> {
        let params: [String: Any] = [
            "q": artist,
            "type": "artist",
            "per_page": NetworkingConstant.PaginationSize,
            "page": page
        ]
        guard var components = URLComponents(string: "https://api.discogs.com/database/search")
        else {
            return .failure(.invalidURL)
        }
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }

        guard let finalURL = components.url
        else {
            return .failure(.invalidURL)
        }

        do {
            let response: Search = try await networkInteractor.getModelDTO(request: finalURL)
            return .success(response)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.general(error))
        }
    }
    
    func getArtistDetails(with id: Int) async throws -> Result<Artist, NetworkError> {
        guard let artistCallbackURL = URL(string: "https://api.discogs.com/artists/\(id)")
        else {
            return .failure(.invalidURL)
        }

        do {
            let response: Artist = try await networkInteractor.getModelDTO(request: artistCallbackURL)
            return .success(response)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.general(error))
        }
    }

    func getArtistReleases(artistId: Int, page: Int) async throws -> Result<Releases, NetworkError> {
        let params: [String: Any] = [
            "sort": "year", // year, title, format
            "sort_order": "asc",
            "page": page,
            "per_page": NetworkingConstant.PaginationSize
        ]
        guard var components = URLComponents(string: "https://api.discogs.com/artists/\(artistId)/releases")
        else {
            return .failure(.invalidURL)
        }
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }

        guard let finalURL = components.url
        else {
            return .failure(.invalidURL)
        }

        do {
            let response: Releases = try await networkInteractor.getModelDTO(request: finalURL)
            return .success(response)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.general(error))
        }
    }
}
