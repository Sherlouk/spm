import Foundation
import ShellOut

public extension ShellOutCommand {
    
    /// Print parsed Package.swift as JSON String.
    static func spmDumpPackage() -> ShellOutCommand {
        return ShellOutCommand(string: "swift package dump-package")
    }
    
}
