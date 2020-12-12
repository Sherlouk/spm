import Foundation
import ShellOut
import ShellCommands
import ConsoleKit

struct PackageDumper {
    
    func parsePackage(at path: String, name: String? = nil, console: Console) -> Package {
        let nameSuffix: String = name == nil ? "" : " \(name!)"
        let bar = console.loadingBar(title: "Parsing Package" + nameSuffix)
        bar.start()
        
        do {
            let packageJSON = try shellOut(to: .spmDumpPackage(), at: path)
            bar.activity.title = "Decoding Package" + nameSuffix
            
            let decoder = JSONDecoder()
            let package = try decoder.decode(Package.self, from: Data(packageJSON.utf8))
            bar.succeed()
            
            return package
        } catch {
            bar.fail()
            console.error("\n\(error)\n")
            exit(EXIT_FAILURE)
        }
    }
    
}
