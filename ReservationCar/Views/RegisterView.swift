import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var cedula = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var passwordMatch = true // Estado para verificar si las contraseñas coinciden
    
    var body: some View {
        NavigationStack { // Usamos NavigationStack para permitir el botón de regreso
            VStack {
                TextField("Name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.words) // Autocapitalización para el nombre
                
                TextField("Cédula", text: $cedula)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none) // Deshabilitar autocapitalización para el email
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                if !passwordMatch {
                    Text("Las contraseñas no coinciden")
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                Button(action: {
                    registerUser()
                }) {
                    Text("Register")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button("Back") {
                    presentationMode.wrappedValue.dismiss() // Regresa a la pantalla de inicio
                }
                .padding()
            }
            .padding()
            .navigationBarBackButtonHidden(false) // Aseguramos que el botón de regreso esté visible
            .navigationTitle("Register") // Título para la barra de navegación
        }
    }
    
    func registerUser() {
        if password != confirmPassword {
            passwordMatch = false
            return
        }
        
        print("User registered successfully")
        print("Name: \(name), Cédula: \(cedula), Email: \(email), Password: \(password)")
    }
}
