import Foundation
import ShellOut

public extension ShellOutCommand {
    
    /// Locate a program file in the user's path.
    static func locateExecutable(named executableName: String) -> ShellOutCommand {
        return ShellOutCommand(string: "which \(executableName)")
    }
    
}

public func shellCommandExists(_ executable: String) throws {
    enum CommandError: Error {
        case commandDoesNotExist(String)
    }
    
    let process = Process()
    
    process.environment = [
        "PATH": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    ]
    
    do {
        try shellOut(to: .locateExecutable(named: executable), process: process)
    } catch {
        throw CommandError.commandDoesNotExist(executable)
    }
}
