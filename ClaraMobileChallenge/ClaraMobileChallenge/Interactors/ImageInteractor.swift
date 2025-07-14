//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import SwiftUI

protocol ImageInteractor {
    func getLocalImage(url: URL) async throws -> UIImage?
    func getImageLocally(url: URL?) -> UIImage?
    @discardableResult func getRemoteImage(url: URL?) async throws -> UIImage?
    func remoteImageExistAtCachePath(_ url: URL) -> Bool
}

extension ImageInteractor {
    @discardableResult func getRemoteImage(url: URL?) async throws -> UIImage? {
        guard let url else { return nil }
        guard !remoteImageExistAtCachePath(url) else {
            return try await getLocalImage(url: url)
        }

        var path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.absoluteString
        path += "\(url.lastPathComponent)"
        let localPath = URL(string: path)!

        let (data, _) = try await URLSession.shared.getData(from: url)

        if let image = UIImage(data: data), let jpgData = image.jpegData(compressionQuality: 1) {
            try jpgData.write(to: localPath, options: .atomic)
            return image
        } else {
//            Debug.eval { print("Error downloading image \(path)") }
            return nil
        }
    }

    func getLocalImage(url: URL) async throws -> UIImage? {
        guard remoteImageExistAtCachePath(url) else {
//            Debug.eval { print("Image \(url.lastPathComponent) doesn't exist locally") }
            return nil
        }

        var path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.absoluteString
        path += "\(url.lastPathComponent)"
        let localPath = URL(string: path)!

        if let image = UIImage(contentsOfFile: localPath.path) {
            return image
        } else {
//            Debug.eval { print("Image \(localPath) doesn't exist locally") }
            return nil
        }
    }

    func getImageLocally(url: URL?) -> UIImage? {
        guard let url else { return nil }

        guard remoteImageExistAtCachePath(url) else {
//            Debug.eval { print("Image \(url.lastPathComponent) doesn't exist locally") }
            return nil
        }

        var path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.absoluteString
        path += "\(url.lastPathComponent)"
        let localPath = URL(string: path)!

        if let image = UIImage(contentsOfFile: localPath.path) {
            return image
        } else {
//            Debug.eval { print("Image \(localPath) doesn't exist locally") }
            return nil
        }
    }

    func remoteImageExistAtCachePath(_ url: URL) -> Bool {
        var path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.absoluteString
        path += "\(url.lastPathComponent)"
        let localPath = URL(string: path)!

        return FileManager.default.fileExists(atPath: localPath.path)
    }
}

struct ConcreteImageInteractor: ImageInteractor { }
