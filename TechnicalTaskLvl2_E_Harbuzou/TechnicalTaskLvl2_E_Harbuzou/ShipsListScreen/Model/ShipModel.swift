import UIKit

struct Ship: Decodable {
    let name: String
    let image: URL?
    let type: String
    let builtYear: Int?
    let weightRaw: Int?
    let homePort: String?
    let roles: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case type
        case builtYear = "year_built"
        case weightRaw = "mass_kg"
        case homePort = "home_port"
        case roles
    }
    var weight: String {
        weightRaw != nil ? "\(weightRaw! / 1000) \(Constants.tons)" : Constants.unknown
    }
    
    var rolesDescription: String {
        roles.joined(separator: ", ")
    }
}
