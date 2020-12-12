import Foundation
import ConsoleKit

class PackageTraverser {
    
    let initialPath: String
    let dumper = PackageDumper()
    let console: Console
    
    private var packageLookup = Set<String>()
    
    init(initialPath: String, console: Console) {
        self.initialPath = initialPath
        self.console = console
    }
    
    func launch() -> (Package, [Package]) {
        let initialPackage = dumper.parsePackage(at: initialPath, console: console)
        return (initialPackage, traverse(initialPackage))
    }
    
    private func traverse(_ package: Package) -> [Package] {
        var builder = [Package]()

        builder.append(package)

        package.dependencies.forEach { dependency in
            guard dependency.isLocal else {
                return
            }
            
            guard packageLookup.contains(dependency.name) == false else {
                return
            }
            
            packageLookup.insert(dependency.name)
            
            let newPackage = dumper.parsePackage(
                at: dependency.url.absoluteString,
                name: dependency.name,
                console: console
            )

            builder.append(contentsOf: traverse(newPackage))
        }

        return builder
    }
    
}
