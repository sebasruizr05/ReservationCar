import SwiftUI

struct AdminView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showReservationView = false // Para mostrar la vista de gestión de reservas
    
    var body: some View {
        NavigationView {
            TabView {
                // Dashboard Principal
                VStack {
                    Text("Welcome Admin")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Botón para ir a la vista de reservas
                    Button(action: {
                        showReservationView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar.badge.clock") // Icono para las reservas
                                .foregroundColor(.blue)
                            Text("Manage Reservations")
                                .font(.headline)
                                .foregroundColor(.blue) // Solo texto azul
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity) // Centra el botón horizontalmente
                    .padding(.top, 50) // Le damos un margen para que no esté pegado al texto anterior
                    
                    // Texto descriptivo para Manage Reservations
                    Text("Here you can view and manage reservations made by users.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    
                    // Navegación a Manage Vehicles
                    NavigationLink(destination: VehicleManagementView()) {
                        HStack {
                            Image(systemName: "car.fill") // Icono para gestionar vehículos
                                .foregroundColor(.blue)
                            Text("Manage Vehicles")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                    }
                    
                    // Texto descriptivo para Manage Vehicles
                    Text("Here you can manage the vehicles listed in the app.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    
                    // Navegación a AdminUserManagementView
                    NavigationLink(destination: AdminUserManagementView()) {
                        HStack {
                            Image(systemName: "person.fill") // Icono para gestionar usuarios
                                .foregroundColor(.blue)
                            Text("Manage Users")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                    }
                    
                    // Texto descriptivo para Manage Users
                    Text("Here you can view and manage the list of registered users in the app.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    
                    Spacer()
                }
                .tabItem {
                    Image(systemName: "house.fill")
                        .imageScale(.small)
                    Text("Dashboard")
                        .font(.footnote)
                }
                
                // Botón para cerrar sesión
                Button(action: {
                    logoutUser() // Llamamos a la función para cerrar sesión
                }) {
                    VStack {
                        Image(systemName: "power")
                            .imageScale(.small)
                        Text("Logout")
                            .font(.footnote)
                    }
                }
                .tabItem {
                    Image(systemName: "power")
                    Text("Logout")
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true) // Ocultar el botón de regreso
            .navigationBarHidden(true) // Ocultar toda la barra de navegación
            .sheet(isPresented: $showReservationView) {
                ReservationView() // Mostrar la vista de gestión de reservas
            }
        }
    }
    
    // Lógica de cierre de sesión
    func logoutUser() {
        print("User logged out")
        presentationMode.wrappedValue.dismiss() // Regresar al login
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
