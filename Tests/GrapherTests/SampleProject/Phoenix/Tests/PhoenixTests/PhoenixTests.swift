import XCTest
@testable import Phoenix

final class PhoenixTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Phoenix().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
