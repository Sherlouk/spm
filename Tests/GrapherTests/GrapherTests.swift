import XCTest
import ConsoleKit
@testable import Grapher

final class GrapherTests: XCTestCase {
    
    func testDumper() throws {
        let projectRoot = #filePath.components(separatedBy: "/Tests/")[0]
        let testProject = projectRoot + "/Tests/GrapherTests/SampleProject/Celeste"
        
        let package = PackageDumper().parsePackage(at: testProject, console: TestConsole())
        
        XCTAssertEqual(package.name, "Celeste")
        XCTAssertEqual(package.toolsVersion, "5.3.0")
    }
    
    func testTraverser() throws {
        let projectRoot = #filePath.components(separatedBy: "/Tests/")[0]
        let testProject = projectRoot + "/Tests/GrapherTests/SampleProject/Luna"
        
        let traverser = PackageTraverser(initialPath: testProject, console: TestConsole())
        let (initialPackage, allPackages) = traverser.launch()
        
        XCTAssertEqual(initialPackage.name, "Luna")
        XCTAssertEqual(allPackages.map { $0.name }, [
            "Luna", "Celeste", "Elektra", "Nova", "Orion", "Lyra", "Phoenix", "Portia"
        ])
    }
    
    func testRelationship() throws {
        let projectRoot = #filePath.components(separatedBy: "/Tests/")[0]
        let testProject = projectRoot + "/Tests/GrapherTests/SampleProject/Luna"
        
        let traverser = PackageTraverser(initialPath: testProject, console: TestConsole())
        let (initialPackage, allPackages) = traverser.launch()
        
        let relationships = RelationshipGenerator().createRelationships(
            initialPackage: initialPackage,
            allPackages: allPackages
        )
        
        let output = relationships.map { relationship in
            "\(relationship.lhs.name) - \(relationship.rhs.name)"
        }
        
        XCTAssertEqual(output, [
            "Luna - Celeste",
            "Luna - Elektra",
            "Elektra - Nova",
            "Elektra - Orion",
            "Orion - Celeste",
            "Orion - SnapshotTesting",
            "Luna - Lyra",
            "Luna - Nova",
            "Luna - Orion",
            "Orion - Celeste",
            "Orion - SnapshotTesting",
            "Luna - Phoenix",
            "Phoenix - SnapshotTesting",
            "Luna - Portia"
        ])
    }
    
}

final class TestConsole: Console {
    func clear(_ type: ConsoleClear) {}
    func output(_ text: ConsoleText, newLine: Bool) {}
    func input(isSecure: Bool) -> String { return "" }
    var size: (width: Int, height: Int) = (0,0)
    func report(error: String, newLine: Bool) {}
    var userInfo: [AnyHashable : Any] = [:]
    init() {}
}
