import XCTest
import ConsoleKit
import Files
@testable import Grapher

final class NomnomlTests: XCTestCase {
    
    func testNommnomlFormatter() throws {
        let nodes: [Node] = [
            .init(name: "One", isRemote: true),
            .init(name: "Two", isRemote: false),
            .init(name: "Three", isRemote: false),
        ]
        
        let relationships = [
            Relationship(lhs: nodes[0], rhs: nodes[1]),
            Relationship(lhs: nodes[1], rhs: nodes[2]),
            Relationship(lhs: nodes[2], rhs: nodes[0]),
        ]
        
        XCTAssertEqual(NomnomlFormatter(relationships: relationships).generate(), """
        #.remote: fill=pink
        [<remote>One] -> [<local>Two]
        [<local>Two] -> [<local>Three]
        [<local>Three] -> [<remote>One]
        """)
    }
    
    func testNomnomlExporter() throws {
        let projectRoot = #filePath.components(separatedBy: "/Tests/")[0]
        let folder = try Folder(path: projectRoot)
        
        let exporter = NomnomlExport(
            contents: """
            #.remote: fill=pink
            [<remote>One] -> [<local>Two]
            [<local>Two] -> [<local>Three]
            [<local>Three] -> [<remote>One]
            """,
            outputPath: folder,
            exportName: "test.svg"
        )
        
        try exporter.save()
        
        let file = try folder.file(named: "test.svg")
        let fileContents = try file.readAsString()
        try? file.delete()
        
        XCTAssert(fileContents.contains("<svg "))
        XCTAssert(fileContents.contains(">One<"))
        XCTAssert(fileContents.contains("#.remote: fill=pink"))
    }
    
}
