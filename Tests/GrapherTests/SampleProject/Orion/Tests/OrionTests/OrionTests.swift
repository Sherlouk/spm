import XCTest
@testable import Orion

final class OrionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Orion().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
