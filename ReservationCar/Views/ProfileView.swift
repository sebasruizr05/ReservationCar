import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var imageURL = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showingImagePicker = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    let userID = Auth.auth().currentUser?.uid

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            } else if !imageURL.isEmpty, let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
            }

            TextField("Nombre", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Nueva contraseña", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Seleccionar imagen de perfil") {
                showingImagePicker.toggle()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Button("Guardar cambios") {
                updateProfile()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .onAppear {
            loadUserData()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Perfil"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func loadUserData() {
        guard let userID = userID else { return }

        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.name = data["name"] as? String ?? ""
                self.email = data["email"] as? String ?? ""
                self.imageURL = data["profileImageURL"] as? String ?? ""
            }
        }
    }

    func updateProfile() {
        guard let userID = userID else { return }

        // Validación básica
        guard !name.isEmpty, !email.isEmpty else {
            alertMessage = "El nombre y el correo no pueden estar vacíos."
            showAlert = true
            return
        }

        isLoading = true
        let db = Firestore.firestore()
        var updates: [String: Any] = ["name": name, "email": email]
        let dispatchGroup = DispatchGroup()

        // Subir imagen si fue seleccionada
        if let image = selectedImage {
            dispatchGroup.enter()
            ImageUploadService.uploadProfileImage(image, for: userID) { result in
                switch result {
                case .success(let url):
                    updates["profileImageURL"] = url
                case .failure(let error):
                    alertMessage = "Error al subir la imagen: \(error.localizedDescription)"
                    showAlert = true
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            db.collection("users").document(userID).updateData(updates) { error in
                if let error = error {
                    alertMessage = "Error al actualizar perfil: \(error.localizedDescription)"
                } else {
                    alertMessage = "Perfil actualizado correctamente."
                    self.imageURL = updates["profileImageURL"] as? String ?? self.imageURL
                }
                showAlert = true
            }

            // Actualizar email y contraseña en Firebase Auth
            if let user = Auth.auth().currentUser {
                if email != user.email {
                    user.updateEmail(to: email) { error in
                        if let error = error {
                            alertMessage = "Error al actualizar el email: \(error.localizedDescription)"
                            showAlert = true
                        }
                    }
                }

                if !password.isEmpty {
                    user.updatePassword(to: password) { error in
                        if let error = error {
                            alertMessage = "Error al actualizar la contraseña: \(error.localizedDescription)"
                            showAlert = true
                        }
                    }
                }
            }

            isLoading = false
        }
    }
}
