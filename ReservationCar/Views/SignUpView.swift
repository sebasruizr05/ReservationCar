import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var role: UserRole = .client // Por defecto, el usuario es un cliente
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("Select Role", selection: $role) {
                Text("Client").tag(UserRole.client)
                Text("Admin").tag(UserRole.admin)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: {
                // Aquí va la lógica para registrar al usuario
                registerUser()
            }) {
                Text("Sign Up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    func registerUser() {
        print("User registered with role: \(role)")
    }
}
