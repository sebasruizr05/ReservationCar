import SwiftUI

struct RentadorView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    @ObservedObject var reservationController: ReservationController
    
    var body: some View {
        TabView {
            // Vista de la lista de vehículos
            VehiclesView() // Aquí se muestra la lista de vehículos
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Car List")
                }
            
            // Vista de reservas del usuario
            UserReservationView(reservationController: reservationController)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("My Reservations")
                }
            
            // Vista del mapa
            MapView() // Aquí se muestra el mapa
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            
            // Vista del perfil
            ProfileView() // Aquí se muestra el perfil del rentador
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
            // Botón para cerrar sesión
            Button(action: {
                logoutUser() // Cierra sesión
            }) {
                VStack {
                    Image(systemName: "power") // Icono de apagar (cerrar sesión)
                    Text("Logout")
                }
            }
            .tabItem {
                Image(systemName: "power") // Icono de apagado
                Text("Logout")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func logoutUser() {
        print("User logged out")
        dismiss() // Usamos dismiss() para salir de la vista actual y regresar
    }
}

struct RentadorView_Previews: PreviewProvider {
    static var previews: some View {
        RentadorView(reservationController: ReservationController()) // Pasar el controlador para pruebas
    }
}
