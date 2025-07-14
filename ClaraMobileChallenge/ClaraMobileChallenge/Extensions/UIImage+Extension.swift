//
//  UIImage+Extension.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import UIKit

extension UIImage {
    func loadImageWitLocalCache(url: URL?) async -> UIImage? {
        guard let url else { return nil }
        let imageInteractor = ConcreteImageInteractor()

        return if let localImage = try? await imageInteractor.getLocalImage(url: url) {
            localImage
        } else {
            try? await imageInteractor.getRemoteImage(url: url)
        }
    }
}
