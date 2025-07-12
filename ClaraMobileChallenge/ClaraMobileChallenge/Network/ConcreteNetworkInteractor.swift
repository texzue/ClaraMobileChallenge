//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

final class ConcreteNetworkInteractor: NetworkInteractor {
    func getModelDTO<ModelDTO: Codable>(request: URL) async throws -> ModelDTO {
        let response = try await OauthAuthenticator.shared.performOauthRequest(with: request)
        switch response {
        case .success(let response):
            guard let data = response.data
            else {
                throw NetworkError.noContent
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let modelDTO = try JSONDecoder().decode(ModelDTO.self, from: data)
                return modelDTO
            } catch {
                throw NetworkError.dataCorrupted(error)
            }
        case .failure(let error):
            throw NetworkError.general(error)
        }
    }
}
