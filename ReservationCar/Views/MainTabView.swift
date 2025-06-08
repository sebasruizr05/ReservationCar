import SwiftUI

struct MainTabView: View {
    var role: UserRole
    @ObservedObject var userController: UserController // Añadir el controlador de usuario
    
    var body: some View {
        TabView {
            // Si el rol es "admin", muestra vistas de administración
            if role == .admin {
                AdminView()
                    .tabItem {
                        Label("Admin", systemImage: "star.fill")
                    }
            } else {
                // Si el rol es "client", muestra vistas de usuario normal
                VehiclesView()
                    .tabItem {
                        Label("Vehicles", systemImage: "car.fill")
                    }
            }
            
            // Aquí pasamos el userController a ProfileView
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(role: .client, userController: UserController()) 
    }
}
