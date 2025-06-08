import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var cedula = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var passwordMatch = true
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Nombre", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.words)

                TextField("Cédula", text: $cedula)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)

                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                SecureField("Contraseña", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Confirmar Contraseña", text: $confirmPassword)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if !passwordMatch {
                    Text("Las contraseñas no coinciden")
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }

                Button(action: {
                    registerUser()
                }) {
                    Text("Registrarse")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button("Volver") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(false)
            .navigationTitle("Registro")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Registro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func registerUser() {
        guard !name.isEmpty, !cedula.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            alertMessage = "Por favor completa todos los campos."
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            passwordMatch = false
            alertMessage = "Las contraseñas no coinciden."
            showAlert = true
            return
        }

        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        AuthService.shared.signUp(name: name, cedula: cedula, email: trimmedEmail, password: trimmedPassword) { result in
            switch result {
            case .success:
                alertMessage = "Usuario registrado correctamente."
                showAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    presentationMode.wrappedValue.dismiss()
                }
            case .failure(let error):
                alertMessage = "Error al registrar: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}
