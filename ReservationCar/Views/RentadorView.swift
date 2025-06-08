import SwiftUI

struct RentadorView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        TabView {
            // Lista de vehículos
            VehiclesView()
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Car List")
                }

            // Reservas del usuario autenticado
            UserReservationView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("My Reservations")
                }

            // Mapa
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }

            // Perfil
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }

            // Logout
            Button(action: {
                logoutUser()
            }) {
                VStack {
                    Image(systemName: "power")
                    Text("Logout")
                }
            }
            .tabItem {
                Image(systemName: "power")
                Text("Logout")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    func logoutUser() {
        AuthService.shared.signOut()
        dismiss()
    }
}

struct RentadorView_Previews: PreviewProvider {
    static var previews: some View {
        RentadorView()
    }
}
