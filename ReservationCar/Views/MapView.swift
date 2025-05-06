import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Coordenadas de ejemplo (San Francisco)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // Modelo de marcador para los vehículos
    struct LocationMarker: Identifiable {
        var id = UUID() // Un identificador único para cada marcador
        var coordinate: CLLocationCoordinate2D
        var title: String
    }
    
    // Ejemplo de marcador para vehículos
    let vehicleLocations = [
        LocationMarker(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), title: "RentaCar"),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Map of Pickups")
                    .font(.title2)
                    .padding()
                
                // Muestra el mapa usando el estado de la región
                Map(coordinateRegion: $region, annotationItems: vehicleLocations) { location in
                    MapPin(coordinate: location.coordinate, tint: .blue) // Marcador de vehículo
                }
                .edgesIgnoringSafeArea(.all) // Hacer que el mapa ocupe toda la pantalla
            }
            .navigationBarTitle("Map", displayMode: .inline)
        }
    }
}
