import Foundation

enum UserRole: String {
    case client
    case admin
}

struct User: Identifiable{
    var id: UUID
    var name: String
    var email: String
    var password: String
    var role: UserRole   
    var profileImage: String
}
