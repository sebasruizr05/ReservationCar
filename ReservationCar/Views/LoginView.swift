import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var email = ""
    @State private var password = ""

    @State private var isAuthenticated = false
    @State private var navigateToVehicles = false
    @State private var navigateToAdmin = false

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    loginUser()
                }) {
                    Text("Login")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button("Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()

                NavigationLink(destination: RentadorView(), isActive: $navigateToVehicles) {
                    EmptyView()
                }

                NavigationLink(destination: AdminView(), isActive: $navigateToAdmin) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Login")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Inicio de sesión"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func loginUser() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty, !trimmedPassword.isEmpty else {
            alertMessage = "Por favor completa todos los campos."
            showAlert = true
            isAuthenticated = false
            return
        }

        AuthService.shared.signIn(email: trimmedEmail, password: trimmedPassword) { result in
            switch result {
            case .success(_, let role):
                isAuthenticated = true
                alertMessage = "Inicio de sesión exitoso."
                showAlert = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    if role == "admin" {
                        navigateToAdmin = true
                    } else {
                        navigateToVehicles = true
                    }
                }

            case .failure(let error):
                isAuthenticated = false
                alertMessage = "Error al iniciar sesión: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}
