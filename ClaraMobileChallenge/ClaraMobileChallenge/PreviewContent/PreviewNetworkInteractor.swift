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

        let model: ModelDTO = try BundleFileManager.loadDataFromFile(from: fileName)
        return model
    }

    // MARK: Private Methods

    private func sleepTask() async throws {
        try await Task.sleep(nanoseconds: timeOutInterval)
    }
}
