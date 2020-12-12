import Foundation
import Files
import ShellOut
import ShellCommands

// Saves a local `svg` file from the provided Nomnoml syntax.
struct NomnomlExport {
    
    let contents: String
    let outputPath: Folder
    let exportName: String
    
    func save() throws {
        // Create unique file name
        let fileName = "nomnoml-temp-\(UUID().uuidString).noml"
        
        // Save the noml file
        let temporaryFolder = Folder.temporary
        try temporaryFolder.createFile(named: fileName, contents: Data(contents.utf8))
        
        // Generate the SVG
        let process = Process()
        
        process.environment = [
            "PATH": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        ]
        
        try shellOut(to: .exportNomnoml(fileName: fileName, exportPath: exportName), at: temporaryFolder.path, process: process)
        
        // Move the file
        try? outputPath.file(named: exportName).delete() // override any existing file
        try temporaryFolder.file(named: exportName).move(to: outputPath)
        
        // Cleanup
        try? temporaryFolder.file(named: fileName).delete()
    }
    
}
