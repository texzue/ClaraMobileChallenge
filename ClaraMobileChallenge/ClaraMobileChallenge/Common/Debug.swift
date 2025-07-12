//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

final class Debug {
    static var isActive = true
    static func eval(completion: () -> Void) {
#if DEBUG
        guard isActive else { return }
        completion()
#endif
    }
}
