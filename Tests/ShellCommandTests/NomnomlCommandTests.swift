import XCTest
import ShellOut
@testable import ShellCommands

final class NomnomlCommandTests: XCTestCase {
    
    func testExport() throws {
        let projectRoot = #filePath.components(separatedBy: "/Tests/")[0]
        let fixturesFolder = projectRoot + "/Tests/ShellCommandTests/Fixtures/"
        
        let process = Process()
        
        process.environment = [
            "PATH": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        ]
        
        try shellOut(
            to: .exportNomnoml(fileName: "test.noml", exportPath: "test.svg"),
            at: fixturesFolder,
            process: process
        )
        
        let fileURL = URL(fileURLWithPath: fixturesFolder + "test.svg")
        let data = try Data(contentsOf: fileURL)
        let contents = try XCTUnwrap(String(data: data, encoding: .utf8))
        
        // Check for a few known values
        XCTAssert(contents.contains("<svg "))
        XCTAssert(contents.contains(">SPMBridge<"))
        XCTAssert(contents.contains(">SnapshotTesting<"))
        
    }
    
}
