//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

protocol NetworkInteractor {
    func getModelDTO<ModelDTO: Codable>(request: URL) async throws -> ModelDTO
}
