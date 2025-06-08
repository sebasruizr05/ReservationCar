import Foundation

enum UserRole: String, CaseIterable, Codable{
    case client
    case admin
}

struct User: Identifiable{
    var id: String
    var name: String
    var email: String
    var password: String
    var role: UserRole   
    var profileImage: String
}
