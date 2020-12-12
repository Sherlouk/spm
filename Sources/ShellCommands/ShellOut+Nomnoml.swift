import Foundation
import ShellOut

public extension ShellOutCommand {
    
    /// Generate SVG diagram at the given exportPath given the provided file.
    static func exportNomnoml(fileName: String, exportPath: String) -> ShellOutCommand {
        return ShellOutCommand(string: "nomnoml \"T\(fileName)\" > \"\(exportPath)\"")
    }
    
}
