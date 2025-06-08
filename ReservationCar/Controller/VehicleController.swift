import Foundation

class VehicleController: ObservableObject {
    @Published var vehicles: [Vehicle] = [
        Vehicle(name: "Mazda CX-30", price: 100, image: "car1", description: "A sleek and dynamic design, ideal for both city driving and adventure."),
        Vehicle(name: "Lexus RX", price: 150, image: "car2", description: "A luxury SUV featuring advanced technology and a premium interior, providing comfort and performance."),
        Vehicle(name: "Toyota Tacoma", price: 200, image: "car3", description: "A rugged and reliable pickup truck, perfect for off-road adventures.")
    ]

    func addVehicle(vehicle: Vehicle) {
        vehicles.append(vehicle)
    }

    func deleteVehicle(at offsets: IndexSet) {
        vehicles.remove(atOffsets: offsets)
    }

    func updateVehicle(vehicle: Vehicle, newName: String, newPrice: Double, newDescription: String, newImage: String) {
        if let index = vehicles.firstIndex(where: { $0.id == vehicle.id }) {
            vehicles[index].name = newName
            vehicles[index].price = newPrice
            vehicles[index].description = newDescription
            vehicles[index].image = newImage
        }
    }
}
