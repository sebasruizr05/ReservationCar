import SwiftUI

struct AdminUserManagementView: View {
    @ObservedObject var userController = UserController() // Controlador de usuarios
    
    var body: some View {
        VStack {
            Text("Manage Users")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            List {
                // Recorremos todos los usuarios
                ForEach(userController.users) { user in
                    HStack {
                        Text(user.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            if let index = userController.users.firstIndex(where: { $0.id == user.id }) {
                                userController.deleteUser(at: IndexSet([index]))
                            }
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
        }
        .padding()
    }
}
