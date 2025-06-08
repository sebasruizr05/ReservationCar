import SwiftUI

struct VehiclesView: View {
    @State private var searchText = ""
    @StateObject private var reservationController = ReservationController()

    let vehicleData = [
        Vehicle(name: "Mazda CX-30", price: 100, image: "car1", description: "A sleek and dynamic design, ideal for both city driving and adventure."),
        Vehicle(name: "Lexus RX", price: 150, image: "car2", description: "A luxury SUV featuring advanced technology and a premium interior."),
        Vehicle(name: "Toyota Tacoma", price: 200, image: "car3", description: "A rugged and reliable pickup truck, perfect for off-road adventures.")
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
                        VehicleCell(vehicle: vehicle)
                    }
                }
                .navigationBarTitle("Vehicles")
            }
        }
    }
}
