import XCTest
@testable import Elektra

final class ElektraTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Elektra().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
