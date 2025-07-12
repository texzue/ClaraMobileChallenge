//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import SwiftUI

extension UIDevice {
    static var topInsetSize: CGFloat {
        (UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .safeAreaInsets
            .top ?? 0) + 40.0
    }
    
    static var bottomInsetSize: CGFloat {
        (UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .safeAreaInsets
            .bottom ?? 0) + 40.0
    }

    static var isIpad: Bool {
        current.userInterfaceIdiom == .pad
    }
}
