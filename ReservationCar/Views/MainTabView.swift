import SwiftUI

struct MainTabView: View {
    var role: UserRole
    
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
