import SwiftUI

struct VehiclesView: View {
    @State private var searchText = "" // Estado para la búsqueda
    
    @StateObject private var reservationController = ReservationController() // Instanciar el ReservationController
    
    let vehicleData = [
        Vehicle(name: "Mazda CX-30", price: 100, image: "car1", description: "The Mazda CX-30 is a compact SUV with a sleek and dynamic design, ideal for both city driving and adventure."),
        Vehicle(name: "Lexus RX", price: 150, image: "car2", description: "The Lexus RX is a luxury SUV featuring advanced technology and a premium interior, providing both comfort and performance."),
        Vehicle(name: "Toyota Tacoma", price: 200, image: "car3", description: "The Toyota Tacoma is a rugged and reliable pickup truck, perfect for off-road adventures and tough terrain.")
    ]
    
    var filteredVehicles: [Vehicle] {
        vehicleData.filter { vehicle in
            searchText.isEmpty || vehicle.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Vehicles", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                List(filteredVehicles) { vehicle in
                    NavigationLink(destination: VehicleDetailView(vehicle: vehicle, reservationController: reservationController)) {
                        VehicleCell(vehicle: vehicle) // Celda que se muestra en la lista
                    }
                }
                .navigationBarTitle("Vehicles")
            }
        }
    }
}
