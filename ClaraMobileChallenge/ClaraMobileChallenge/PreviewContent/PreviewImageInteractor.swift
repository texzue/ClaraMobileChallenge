//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import UIKit

final class PreviewImageInteractor: ImageInteractor {

    private let timeOutInterval: UInt64
    
    init(timeOutInterval: UInt8) {
        self.timeOutInterval = UInt64(timeOutInterval) * 1_000_000_000
    }
    
    func getLocalImage(url: URL) async throws -> UIImage? {
        try await sleepTask()
        return UIImage(named: "testImage")
    }
    
    func getRemoteImage(url: URL) async throws -> UIImage? {
        try await sleepTask()
        return UIImage(named: "testImage")
    }

    func getImageLocally(url: URL) -> UIImage? {
        return UIImage(named: "testImage")
    }

    func remoteImageExistAtCachePath(_ url: URL) -> Bool {
        return true
    }

    private func sleepTask() async throws {
        try await Task.sleep(nanoseconds: timeOutInterval)
    }
}
