import XCTest
import ShellOut
@testable import ShellCommands

final class WhichTests: XCTestCase {
    
    func testWhich() throws {
        do {
            let output = try shellOut(to: .locateExecutable(named: "cat"))
            XCTAssertEqual(output, "/bin/cat")
        }
        
        do {
            try shellOut(to: .locateExecutable(named: "nomnoml"))
            XCTFail("Nomnoml does not exist within the default process path")
        } catch {
            // All good.
        }
        
        do {
            try shellOut(to: .locateExecutable(named: "random-command"))
            XCTFail("Command should not have existed")
        } catch {
            // All good.
        }
        
        do {
            try shellCommandExists("nomnoml")
        }
    }
    
}
