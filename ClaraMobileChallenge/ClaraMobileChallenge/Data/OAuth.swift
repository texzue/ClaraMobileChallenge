//
//  OAuth.swift
//  ClaraMobileChallenge
//
//  Created by alice on 10/07/25.
//

import Foundation
import OAuthSwift

enum DiscogsServerDetails {
    static let baseURLString = "https://api.discogs.com"
}

enum OauthDetails {
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
    case Success = 200              // Requested data is provided in the response body
    case SuccessContinue = 201      // You’ve sent a POST request to a list of resources to create a new one
    case NoContent = 204            // The request was successful, but no data
    case Unauthorized = 400         // You’re attempting to access a resource that first requires authentication
    case Forbidden = 403            // You’re not allowed to access this resource. Even if you authenticated
    case NotFound = 404             // The resource you requested doesn’t exist
    case MethodNotAllowed = 405     // You’re trying to use an HTTP verb that isn’t supported by the resource
    case UnprocessableEntity = 422  // Something semantically wrong with the body of the request. JSON malformed in body
    case InternalServerError = 500
}

final class OauthAuthenticator {
    private let oauthswift = OAuth1Swift(
        consumerKey: OauthDetails.ConsumerKey,
        consumerSecret: OauthDetails.ConsumerSecret,
        requestTokenUrl: OauthDetails.RequestTokenURLString,
        authorizeUrl: OauthDetails.AuthorizeURLSring,
        accessTokenUrl: OauthDetails.AccessTokenURLstring
    )
    
    static let shared = OauthAuthenticator()
    
    func authorize() {
        let _ = oauthswift.authorize(withCallbackURL: OauthDetails.CallbackURLString) { result in
            // result -> Result<OAuthSwift.TokenSuccess, OAuthSwiftError>
            switch result {
            case .success(let token):
                print("token credential: \(token.credential)")
                print("token parameters: \(token.parameters)")
                print("token response: \(String(describing: token.response?.description))")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
