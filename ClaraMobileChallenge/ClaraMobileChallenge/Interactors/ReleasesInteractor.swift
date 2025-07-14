//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

protocol ReleasesInteractor {
    func getReleaseDetails(with id: Int) async throws -> Result<ReleaseDetailsDTO, NetworkError>
}

final class ConcreteReleasesInteractor: ReleasesInteractor {

    private let networkInteractor: NetworkInteractor

    init(networkInteractor: NetworkInteractor) {
        self.networkInteractor = networkInteractor
    }

    func getReleaseDetails(with id: Int) async throws -> Result<ReleaseDetailsDTO, NetworkError> {
        let params: [String: Any] = [
            "curr_abbr": "MXN"
        ]
        guard var components = URLComponents(string: "https://api.discogs.com/releases/\(id)")
        else { return .failure(.invalidURL) }
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }

        guard let finalURL = components.url
        else { return .failure(.invalidURL) }

        do {
            let response: ReleaseDetailsDTO = try await networkInteractor.getModelDTO(request: finalURL)
            return .success(response)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.general(error))
        }
    }
}
