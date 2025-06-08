import Foundation
import FirebaseFirestore

class UserController: ObservableObject {
    @Published var users: [User] = []

    init() {
        fetchUsers()
    }

    // Obtener usuarios desde Firestore
    func fetchUsers() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching users: \(error.localizedDescription)")
                return
            }

            self.users = snapshot?.documents.compactMap { doc in
                let data = doc.data()

                guard let name = data["name"] as? String,
                      let email = data["email"] as? String,
                      let password = data["password"] as? String,
                      let roleString = data["role"] as? String,
                      let role = UserRole(rawValue: roleString),
                      let profileImage = data["profileImage"] as? String else {
                    return nil
                }

                return User(
                    id: doc.documentID,
                    name: name,
                    email: email,
                    password: password,
                    role: role,
                    profileImage: profileImage
                )
            } ?? []
        }
    }

    // Editar perfil del usuario
    func editUserProfile(user: User, newName: String, newEmail: String, newPassword: String, newProfileImage: String) {
        let db = Firestore.firestore()
        db.collection("users").document(user.id).updateData([
            "name": newName,
            "email": newEmail,
            "password": newPassword,
            "profileImage": newProfileImage
        ]) { error in
            if let error = error {
                print("❌ Error updating user: \(error.localizedDescription)")
            } else {
                print("✅ User updated.")
                self.fetchUsers()
            }
        }
    }

    // Eliminar usuario
    func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            Firestore.firestore().collection("users").document(user.id).delete { error in
                if let error = error {
                    print("❌ Error deleting user: \(error.localizedDescription)")
                } else {
                    print("✅ User deleted.")
                    DispatchQueue.main.async {
                        self.users.remove(at: index)
                    }
                }
            }
        }
    }
}
