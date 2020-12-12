import Foundation
import ConsoleKit
import Grapher

final class GraphCommand: Command {
    
    struct Signature: CommandSignature {
        @Option(name: "outputName", help: "The name of the SVG which is exported (example: 'generated.svg')")
        var outputName: String?
        
        @Argument(name: "path", help: "The path to the directory which contains the Swift Package you wish to graph")
        var path: String
    }
    
    var help: String {
        "Creates and exports (in SVG) a visual representation of your package and it's dependency tree"
    }
    
    func run(using context: CommandContext, signature: Signature) throws {
        try Grapher().test(
            console: context.console,
            path: signature.path,
            outputName: signature.outputName
        )
    }
    
}
