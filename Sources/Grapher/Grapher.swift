import Foundation
import ConsoleKit
import ShellOut
import ShellCommands
import Files

public class Grapher {
    
    public init() {
        
    }
    
    public func test(console: Console, path: String, outputName: String?) throws {
        // MARK: - Check Export Capability
        checkForCommand(console: console, command: "nomnoml", installationCommand: "npm install -g nomnoml")
        
        // MARK: - Traverse Packages
        let traverser = PackageTraverser(initialPath: path, console: console)
        let (initialPackage, packages) = traverser.launch()
        
        // MARK: - Generate Package Tree
        let bar = console.loadingBar(title: "Exporting")
        let relationships = RelationshipGenerator().createRelationships(
            initialPackage: initialPackage,
            allPackages: packages
        )
        
        // MARK: - Export
        do {
            let formattedString = NomnomlFormatter(relationships: relationships).generate()
            try NomnomlExport(
                contents: formattedString,
                outputPath: Folder.current,
                exportName: outputName ?? "generated.svg"
            ).save()
            bar.succeed()
            exit(EXIT_SUCCESS)
        } catch {
            bar.fail()
            console.error("\(error)")
            exit(EXIT_FAILURE)
        }
    }
    
    internal func checkForCommand(console: Console, command: String, installationCommand: String) {
        let bar = console.loadingBar(title: "Checking for \(command)")
        
        do {
            bar.start(refreshRate: 10)
            try shellCommandExists(command)
            bar.succeed()
        } catch {
            bar.fail()
            console.error("\n\(command) is not installed, please run `\(installationCommand)` and then try again!\n")
            exit(EXIT_FAILURE)
        }
    }
    
}
