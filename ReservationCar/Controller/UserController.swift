import Foundation

class UserController: ObservableObject {
    @Published var users: [User] = [
        User(id: UUID(), name: "John Doe", email: "johndoe@example.com", password: "password123", role: .client, profileImage: "profile_image"),
        User(id: UUID(), name: "Admin User", email: "admin@example.com", password: "admin123", role: .admin, profileImage: "admin_image")
    ]
    
    // Función para editar el perfil del usuario
    func editUserProfile(user: User, newName: String, newEmail: String, newPassword: String, newProfileImage: String) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index].name = newName
            users[index].email = newEmail
            users[index].password = newPassword
            users[index].profileImage = newProfileImage
        }
    }
    
    // Función para eliminar un usuario (solo lo puede hacer el administrador)
    func deleteUser(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
}
