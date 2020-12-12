import Foundation

struct RelationshipGenerator {
    
    internal func createRelationships(initialPackage: Package, allPackages: [Package]) -> [Relationship] {
        var builder = [Relationship]()
        
        let initialNode = Node(name: initialPackage.name, isRemote: false)
        
        var cycle: ((Node, Package) -> Void)?
            
        cycle = { node, package in
            package.dependencies.forEach {
                let depNode = Node(name: $0.name, isRemote: $0.isRemote)
                builder.append(Relationship(lhs: node, rhs: depNode))
                
                guard let depPkg = allPackages.package(withName: $0.name) else {
                    return
                }
                
                cycle?(depNode, depPkg)
            }
        }
        
        cycle?(initialNode, initialPackage)
        
        return builder
    }
    
}

extension Array where Element == Package {
    
    func package(withName name: String) -> Element? {
        first(where: { $0.name == name })
    }
    
}

struct Node {
    let name: String
    let isRemote: Bool
}

struct Relationship {
    let lhs: Node
    let rhs: Node
}
