import SwiftUI

struct ProfileView: View {
    @ObservedObject var userController: UserController // Usamos el controlador para manejar los datos del usuario
    
    @State private var user: User // Usamos el modelo User aquí para trabajar con los datos de la vista
    @State private var newName = ""
    @State private var newEmail = ""
    @State private var newPassword = ""
    @State private var newProfileImage: UIImage? // Cambiar a UIImage para trabajar con la imagen

    @State private var showingImagePicker = false // Estado para mostrar el ImagePicker
    @State private var selectedImage: UIImage? = nil // Imagen seleccionada
    
    init(userController: UserController) {
        self.userController = userController
        _user = State(initialValue: userController.users.first!) // Cargar el primer usuario o el usuario actual según sea necesario
    }

    var body: some View {
        VStack {
            // Mostrar la imagen de perfil
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding()
            } else {
                // Si no hay imagen seleccionada, mostramos la imagen predeterminada
                Image(user.profileImage) // Usar el nombre de la imagen desde el modelo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding()
            }
            
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
            
            // Botón para editar el perfil
            Button("Edit Profile") {
                self.newName = user.name
                self.newEmail = user.email
                self.newPassword = user.password
                self.newProfileImage = UIImage(named: user.profileImage)
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
                
                // Selector de imagen
                Button("Select Profile Image") {
                    showingImagePicker.toggle()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Save Changes") {
                    updateUserProfile()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .padding()
        .onAppear {
            loadUserData() // Cargar los datos del usuario
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage) // Selector de imágenes
        }
    }
    
    // Cargar los datos de usuario al aparecer la vista
    func loadUserData() {
        self.user = userController.users.first!
    }
    
    // Actualizar el perfil del usuario
    func updateUserProfile() {
        let newImageName = "new_image_name"

        userController.editUserProfile(user: user, newName: newName, newEmail: newEmail, newPassword: newPassword, newProfileImage: newImageName)
        
        // Actualizar la vista después de guardar los cambios
        user.name = newName
        user.email = newEmail
        user.password = newPassword
        user.profileImage = newImageName
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userController: UserController())
    }
}
