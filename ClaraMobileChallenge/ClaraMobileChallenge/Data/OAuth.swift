//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import Foundation
import OAuthSwift

typealias ServiceResponse = (data: Data?, httpResponse: HTTPURLResponse)

enum DiscogsServerDetails {
    static let baseURLString = "https://api.discogs.com"
}

enum OauthConstants {
    static let ConsumerKey = "SgbpgBWRZOdqnpEilzoS"
    static let ConsumerSecret = "XssAOKbOYfFzHMHFZhjIWuHAnEkTbzyS"
    static let RequestTokenURLString = "https://api.discogs.com/oauth/request_token"
    static let AuthorizeURLSring = "https://www.discogs.com/oauth/authorize"
    static let AccessTokenURLstring = "https://api.discogs.com/oauth/access_token"
    static let UserAgent = "ClaraMobileChallengeETS"
    static let CallbackURLString = "AppaClaraMobileChallenge://oauth-callback"
}

struct OAuthResponse {
    let OauthToken: String
    let OauthTokenSecret: String
}

enum DiscogsServerResponseCode: Int {
    case Success = 200                  // Requested data is provided in the response body
    case SuccessContinue = 201          // You’ve sent a POST request to a list of resources to create a new one
    case NoContent = 204                // The request was successful, but no data
    case Unauthorized = 400             // You’re attempting to access a resource that first requires authentication
    case AuthenticationRequired = 401   // You’re attempting to access a resource that first requires authentication
    case Forbidden = 403                // You’re not allowed to access this resource. Even if you authenticated
    case NotFound = 404                 // The resource you requested doesn’t exist
    case MethodNotAllowed = 405         // You’re trying to use an HTTP verb that isn’t supported by the resource
    case UnprocessableEntity = 422      // Something semantically wrong with the body of the request. JSON malformed in body
    case InternalServerError = 500
}

enum OAuthError: Error {
    case invalidURL
    case invalidAuthentication
    case invalidData
    case emptyData
    case invalidResponse(error: OAuthSwiftError)
}

final class OauthAuthenticator {
    
    private static let oauthswift = OAuth1Swift(
        consumerKey: OauthConstants.ConsumerKey,
        consumerSecret: OauthConstants.ConsumerSecret,
        requestTokenUrl: OauthConstants.RequestTokenURLString,
        authorizeUrl: OauthConstants.AuthorizeURLSring,
        accessTokenUrl: OauthConstants.AccessTokenURLstring
    )

    static let shared = OauthAuthenticator()
    
    func autenticate() async throws -> Result<OAuthSwift.TokenSuccess, OAuthError> {
        return try await withCheckedThrowingContinuation { continuation in
            _ = OauthAuthenticator.oauthswift.authorize(withCallbackURL: OauthConstants.CallbackURLString) { result in
                switch result {
                case .success(let token):
                    print("oauthToken: \(token.credential.oauthToken)")
                    print("token credential: \(token.credential)")
                    print("token parameters: \(token.parameters)")
                    print("token response: \(String(describing: token.response?.description))")
                    return continuation.resume(returning: .success(token))
                case .failure(let error):
                    print("error: \(String(describing: error))")
                    return continuation.resume(returning: .failure(.invalidResponse(error: error)))
                }
            }
        }
    }

    func getArtists(closure: @escaping (Result<String, OAuthError>) -> Void) {
        guard let artistCallbackURL = URL(string: "https://api.discogs.com/artists/1?callback=callbackname")
        else { closure(.failure(OAuthError.invalidURL)); return }


        _ = OauthAuthenticator.oauthswift.client.get(artistCallbackURL) { result in
            switch result {
            case .success(let response):
                if let response = response.string {
                    closure(.success(response.string))
                } else {
                    closure(.failure(OAuthError.invalidData))
                }
            case .failure(let error):
                closure(.failure(OAuthError.invalidResponse(error: error)))
            }
        }
    }

    func performOauthRequest(with url: URL) async throws -> Result<ServiceResponse, OAuthError> {
        return try await withCheckedThrowingContinuation { continuation in
            
            OauthAuthenticator.oauthswift.client.get(url, headers: constructHeaders()) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: .success((response.data, response.response)))
                case .failure(let error):
                    switch error {
                    case let .requestError(requestError, _):
                        let responseCode = DiscogsServerResponseCode(rawValue: (requestError as NSError).code)
                        switch responseCode {
                        case .AuthenticationRequired:
                            continuation.resume(returning: .failure(.invalidAuthentication))
                        case .Forbidden, .InternalServerError, .MethodNotAllowed, .NoContent, .NotFound, .Success, .SuccessContinue, .Unauthorized, .UnprocessableEntity, .none:
                            continuation.resume(returning: .failure(.invalidResponse(error: error)))
                        }
                    case .accessDenied, .authorizationPending:
                        continuation.resume(returning: .failure(.invalidAuthentication))
                    default:
                        continuation.resume(returning: .failure(.invalidResponse(error: error)))
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func constructHeaders() -> OAuthSwift.Headers {
        .init(
            uniqueKeysWithValues: [
                (key:"User-Agent", value: OauthConstants.UserAgent)
            ]
        )
    }
}
