import SwiftUI

struct WelcomeView: View { 
    @State private var isLogin = true // Variable para controlar si se muestra Login o Registro
    @State private var isPresented = false // Controla la presentación del login o registro
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Welcome to Reservation Car")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Button(action: {
                isLogin = true // Aseguramos que el login se muestre al pulsar Login
                isPresented = true
            }) {
                Text("Login")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Button(action: {
                isLogin = false // Cambia a Register
                isPresented = true // Se presenta la vista de registro
            }) {
                Text("Register")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $isPresented) {
            if isLogin {
                LoginView() // Presenta la vista de Login
            } else {
                RegisterView() // Presenta la vista de Registro
            }
        }
    }
}
