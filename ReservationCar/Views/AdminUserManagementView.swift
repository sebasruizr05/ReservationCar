import SwiftUI

struct AdminUserManagementView: View {
    @ObservedObject var userController = UserController()
    
    var body: some View {
        VStack {
            Text("Manage Users")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            if userController.users.isEmpty {
                Text("🔍 No users found or loading...")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
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
        }
        .padding()
        .onAppear {
            userController.fetchUsers() // Asegura que se recarguen al aparecer
        }
    }
}
