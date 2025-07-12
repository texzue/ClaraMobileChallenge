//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

final class PreviewNetworkInteractor: NetworkInteractor {

    private let fileName: String
    private let timeOutInterval: UInt64

    init(fileName: String, timeOutInterval: UInt64) {
        self.fileName = fileName
        self.timeOutInterval = timeOutInterval
    }

    func getModelDTO<ModelDTO: Codable>(request: URL) async throws -> ModelDTO {
        try await sleepTask()

        let model: ModelDTO = try loadDataFromFile(from: fileName)
        return model
    }

    // MARK: Private Methods

    private func loadDataFromFile<DTO: Decodable>(from fileName: String) throws -> DTO {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(DTO.self, from: data)
    }

    private func sleepTask() async throws {
        try await Task.sleep(nanoseconds: timeOutInterval)
    }
}
