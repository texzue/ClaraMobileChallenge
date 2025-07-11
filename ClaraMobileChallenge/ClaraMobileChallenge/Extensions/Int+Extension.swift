//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import Foundation


private let intUnitConstant: Int = 8
private let doubleUnitConstant: Double = 8.0

extension Int {
    var su: Int {
        return self * intUnitConstant
    }
}

extension Double {
    var su: Double {
        return self * doubleUnitConstant
    }
}
