//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation
import OAuthSwift

typealias ServiceResponse = (data: Data?, httpResponse: HTTPURLResponse)

enum DiscogsServerDetails {
    static let baseURLString = "https://api.discogs.com"
}

enum OauthConstants {
    static let ConsumerKey = Esther.get(.OatmealConsumerKey)
    static let ConsumerSecret = Esther.get(.OatmealConsumerSecret)
    static let RequestTokenURLString = "https://api.discogs.com/oauth/request_token"
    static let AuthorizeURLSring = "https://www.discogs.com/oauth/authorize"
    static let AccessTokenURLstring = "https://api.discogs.com/oauth/access_token"
    static let CallbackURLString = "AppaClaraMobileChallenge://oauth-callback"
}

struct OAuthResponse {
    let OauthToken: String
    let OauthTokenSecret: String
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

    func autenticate() async throws -> Result<OAuthSwift.TokenSuccess, NetworkError> {
        try await withCheckedThrowingContinuation { continuation in
            _ = OauthAuthenticator.oauthswift.authorize(withCallbackURL: OauthConstants.CallbackURLString) { result in
                switch result {
                case .success(let token):
                    Debug.eval {
                        print("oauthToken: \(token.credential.oauthToken)")
                        print("token credential: \(token.credential)")
                        print("token parameters: \(token.parameters)")
                        print("token response: \(String(describing: token.response?.description))")
                    }
                    return continuation.resume(returning: .success(token))
                case .failure(let error):
                    return continuation.resume(returning: .failure(.general(error)))
                }
            }
        }
    }

    func performOauthRequest(with request: URL) async throws -> Result<ServiceResponse, NetworkError> {

        try await withCheckedThrowingContinuation { continuation in
            OauthAuthenticator.oauthswift.client.get(request, headers: constructHeaders()) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: .success((response.data, response.response)))
                case .failure(let error):
                    switch error {
                    case let .requestError(requestError, _):
                        let responseCode = ServerResponseCode(rawValue: (requestError as NSError).code)
                        switch responseCode {
                        case .AuthenticationRequired:
                            continuation.resume(returning: .failure(.invalidAuthentication))
                        case .Forbidden, .InternalServerError, .MethodNotAllowed, .NoContent, .NotFound, .Success, .SuccessContinue, .Unauthorized, .UnprocessableEntity, .none:
                            continuation.resume(returning: .failure(.general(error)))
                        }
                    case .accessDenied, .authorizationPending:
                        continuation.resume(returning: .failure(.accessDenied))
                    default:
                        continuation.resume(returning: .failure(.general(error)))
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func constructHeaders() -> OAuthSwift.Headers {
        .init(
            uniqueKeysWithValues: [
                (key:"User-Agent", value: NetworkingConstant.UserAgent)
            ]
        )
    }
}
