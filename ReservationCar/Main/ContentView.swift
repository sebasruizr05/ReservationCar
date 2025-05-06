import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false // Estado para saber si el usuario está logueado
    @State private var role: UserRole = .client // Para almacenar el rol del usuario (cliente o admin)
    
    var body: some View {
        if isLoggedIn {
            // Si el usuario está logueado, mostramos la vista principal con Tabs
            MainTabView(role: role) // Pasamos el rol para decidir qué vistas mostrar
        } else {
            // Si no está logueado, mostramos la pantalla de inicio
            StartView(isLoggedIn: $isLoggedIn, role: $role) // Usamos StartView para login o registro
        }
    }
}

struct StartView: View {
    @Binding var isLoggedIn: Bool // Bind para actualizar el estado de login
    @Binding var role: UserRole // Bind para actualizar el rol del usuario
    
    var body: some View {
        VStack {
            Button("Login") {
                // Simulamos un login y asignamos el rol
                role = .client // O .admin dependiendo de lo que elijas
                isLoggedIn = true
            }
            .padding()
            
            Button("Register") {
                // Aquí iría el registro
            }
            .padding()
        }
    }
}
