import Foundation

struct Package: Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case name
        case toolsVersion
        case dependencies
    }
    
    enum VersionCodingKeys: String, CodingKey {
        case version = "_version"
    }
    
    let name: String
    let toolsVersion: String
    let dependencies: [PackageDependency]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        
        // Root
        name = try container.decode(String.self, forKey: .name)
        dependencies = try container.decode([PackageDependency].self, forKey: .dependencies)
        
        // Tools Version
        let toolsContainer = try container.nestedContainer(keyedBy: VersionCodingKeys.self, forKey: .toolsVersion)
        toolsVersion = try toolsContainer.decode(String.self, forKey: .version)
    }
    
}

struct PackageDependency: Decodable {
    
    private struct DependencyRequirement: Decodable {
        let range: [[String: String]]?
    }
    
    enum CodingKeys: String, CodingKey {
        case name, url, requirement
    }
    
    let name: String
    let url: URL
    let isLocal: Bool
    
    var isRemote: Bool {
        !isLocal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(URL.self, forKey: .url)
        
        let requirements = try container.decode(DependencyRequirement.self, forKey: .requirement)
        isLocal = requirements.range == nil
    }
    
}
