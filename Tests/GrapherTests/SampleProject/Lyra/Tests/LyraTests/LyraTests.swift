import XCTest
@testable import Lyra

final class LyraTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Lyra().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
