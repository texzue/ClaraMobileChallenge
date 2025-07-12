//  ClaraMobileChallenge
//  Created by Emmanuel Texis

@testable import ClaraMobileChallenge
import XCTest

final class EstherTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEstherLogan() {
        let logan = Esther.get(.OatmealConsumerKey)
        XCTAssertEqual(logan.count, 20)
    }
}
