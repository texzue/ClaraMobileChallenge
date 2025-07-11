//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import Foundation

final class EndpointCaller {
    
    static let shared = EndpointCaller()
    
    func getArtistsAsync() async throws -> Result<SearchArtist, OAuthError> {
        guard let artistCallbackURL = URL(string: "https://api.discogs.com/database/search?release_title=nevermind&artist=nirvana&per_page=30&page=1")
        else { return .failure(OAuthError.invalidURL) }

        let response = try await OauthAuthenticator.shared.performOauthRequest(with: artistCallbackURL)
        switch response {
        case .success(let response):
            guard let data = response.data
            else { return .failure(.emptyData)}
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(SearchArtist.self, from: data)
                return .success(response)
            } catch {
                return .failure(.invalidData)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func searchArtist(artist: String) async throws -> Result<SearchArtist, OAuthError> {
        guard let artistCallbackURL = URL(string: "https://api.discogs.com/database/search?q=\(artist)&type=artist&per_page=30&page=1")
//        guard let artistCallbackURL = URL(string: artist)
        else { return .failure(OAuthError.invalidURL) }

        let response = try await OauthAuthenticator.shared.performOauthRequest(with: artistCallbackURL)
        switch response {
        case .success(let response):
            guard let data = response.data
            else { return .failure(.emptyData)}
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(SearchArtist.self, from: data)
                return .success(response)
            } catch {
                return .failure(.invalidData)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getArtistDetails(id: Int) async throws -> Result<SearchArtist, OAuthError> {
        guard let artistCallbackURL = URL(string: "https://api.discogs.com/database/search?q=\(artist)&type=artist&per_page=30&page=1")
//        guard let artistCallbackURL = URL(string: artist)
        else { return .failure(OAuthError.invalidURL) }

        let response = try await OauthAuthenticator.shared.performOauthRequest(with: artistCallbackURL)
        switch response {
        case .success(let response):
            guard let data = response.data
            else { return .failure(.emptyData)}
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(SearchArtist.self, from: data)
                return .success(response)
            } catch {
                return .failure(.invalidData)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
