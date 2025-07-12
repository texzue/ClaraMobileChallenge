//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

public extension URLSession {
    func getData(from url: URL) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse else { throw NetworkError.HTTPSResponseError }

            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }

    func getData(from urlRequest: URLRequest,
                 delegate: (URLSessionTaskDelegate)? = nil) async throws -> (Data, HTTPURLResponse) {
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: delegate)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.HTTPSResponseError}

            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
}
