import XCTest
import ShellOut
@testable import ShellCommands

final class SwiftCommandTests: XCTestCase {
    
    func testSwiftPackageDump() throws {
        let projectRoot = #filePath.components(separatedBy: "/Tests/")[0]
        let testProject = projectRoot + "/Tests/GrapherTests/SampleProject/Celeste"
        
        let output = try shellOut(to: .spmDumpPackage(), at: testProject)
        
        // Ensure it's valid JSON
        let json = try JSONSerialization.jsonObject(with: Data(output.utf8), options: [])
        let dictionary = try XCTUnwrap(json as? [String: Any])
        
        // Ensure we can pull out a known value
        XCTAssertEqual(dictionary["name"] as? String, "Celeste")
    }
    
}
