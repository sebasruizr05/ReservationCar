import SwiftUI

struct ProfileView: View {
    @State private var user = User(id: UUID(), name: "John Doe", email: "johndoe@example.com", password: "password123", role: .client, profileImage: "profile_image")
    
    @State private var newName = ""
    @State private var newEmail = ""
    @State private var newPassword = ""
    @State private var newProfileImage = ""
    
    @ObservedObject var userController = UserController()
    
    var body: some View {
        VStack {
            // Imagen del perfil
            Image(user.profileImage)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()
            
            // Mostrar el nombre del usuario
            Text(user.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 8)
            
            // Mostrar el correo electrónico
            Text(user.email)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 4)
            
            // Aquí puedes agregar más detalles de la cuenta, como un botón para editar el perfil
            Button("Edit Profile") {
                // Mostrar campos para editar el perfil
                self.newName = user.name
                self.newEmail = user.email
                self.newPassword = user.password
                self.newProfileImage = user.profileImage
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            // Edición de los campos
            VStack {
                TextField("New Name", text: $newName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("New Email", text: $newEmail)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("New Password", text: $newPassword)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("New Profile Image", text: $newProfileImage)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save Changes") {
                    userController.editUserProfile(user: user, newName: newName, newEmail: newEmail, newPassword: newPassword, newProfileImage: newProfileImage)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .padding()
    }
}
