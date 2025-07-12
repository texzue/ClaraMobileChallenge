//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

public enum NetworkError: Error, CustomStringConvertible {
    case general(Error)
    case invalidAuthentication
    case dataCorrupted(Error)
    case noContent
    case accessDenied
    case invalidURL
    case HTTPSResponseError

    public var description: String {
        switch self {
        case .general(let error):
            "Error general \(error.localizedDescription)"
        case .invalidAuthentication:
            "Autethication Error, must reautenticate"
        case .dataCorrupted(let error):
            "Data Corrupted \(error.localizedDescription)"
        case .noContent:
            "No Content"
        case .accessDenied:
            "access denied"
        case .invalidURL:
            "Validate UWL, URL malformated"
        case .HTTPSResponseError:
            "HTTP Response Error"
        }
    }
}
