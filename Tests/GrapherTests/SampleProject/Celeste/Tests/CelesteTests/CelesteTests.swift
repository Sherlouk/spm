import XCTest
@testable import Celeste

final class CelesteTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Celeste().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
