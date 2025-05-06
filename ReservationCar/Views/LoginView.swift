import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isAuthenticated = false // Estado para verificar si el login fue exitoso
    @State private var navigateToVehicles = false // Estado para redirigir al Rentador
    @State private var navigateToAdmin = false // Estado para redirigir al Admin
    @State private var reservationController = ReservationController()
    @State private var userController = UserController() // Instancia del controlador de usuarios
    
    var body: some View {
        NavigationStack { // Usamos NavigationStack para permitir la navegación
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none) // Deshabilitar autocapitalización para el email
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none) // Deshabilitar autocapitalización para la contraseña
                
                Button(action: {
                    loginUser() // Llamamos a la función de login
                }) {
                    Text("Login")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                if isAuthenticated {
                    Text("Login Successful!")
                        .foregroundColor(.green)
                        .padding()
                } else {
                    Text("Invalid credentials")
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button("Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                
                // Uso de NavigationLink con valores dinámicos para activar el destino según el estado
                NavigationLink(destination: RentadorView(reservationController: reservationController, userController: userController), isActive: $navigateToVehicles) {
                    EmptyView() // Esconde el link visualmente, pero sigue funcionando
                }
                
                NavigationLink(destination: AdminView(), isActive: $navigateToAdmin) {
                    EmptyView() // Esconde el link visualmente, pero sigue funcionando
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true) // Ocultar el botón de regreso (flecha hacia atrás)
            .navigationTitle("Login") // Título para la barra de navegación
        }
    }
    
    func loginUser() {
        // Lógica de login simulada: validar email y contraseña
        
        // Definir las credenciales de admin y rentador (usuario de ejemplo)
        let adminEmail = "admin@example.com"
        let adminPassword = "admin123"
        
        let userEmail = "user@example.com"
        let userPassword = "user123"
        
        if email == adminEmail && password == adminPassword {
            // Si las credenciales coinciden con Admin
            print("Admin logged in")
            isAuthenticated = true // Indicamos que el login fue exitoso
            navigateToAdmin = true // Redirige al Admin
        } else if email == userEmail && password == userPassword {
            // Si las credenciales coinciden con el Rentador (usuario de ejemplo)
            print("Rentador logged in")
            isAuthenticated = true // Indicamos que el login fue exitoso
            navigateToVehicles = true // Redirige al Rentador a la vista de Vehicles
        } else {
            // Si las credenciales no son válidas
            print("Invalid credentials")
            isAuthenticated = false // Indicamos que el login falló
        }
    }
}
