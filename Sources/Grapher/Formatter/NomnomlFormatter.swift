import Foundation

struct NomnomlFormatter {
    
    let relationships: [Relationship]
    
    func generate() -> String {
        let formatNode: (Node) -> String = { node in
            let prefix = node.isRemote ? "<remote>" : "<local>"
            return "[\(prefix)\(node.name)]"
        }
        
        let relationshipStrings = relationships.map { relationship in
            "\(formatNode(relationship.lhs)) -> \(formatNode(relationship.rhs))"
        }
        
        return """
        #.remote: fill=lightblue title=bold
        #ranker: longest-path
        #gravity: 1.5
        \(relationshipStrings.joined(separator: "\n"))
        """
    }
    
}
