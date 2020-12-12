import XCTest
@testable import Portia

final class PortiaTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Portia().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
