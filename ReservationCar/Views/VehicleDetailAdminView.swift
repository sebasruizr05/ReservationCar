import SwiftUI

struct VehicleDetailAdminView: View {
    @ObservedObject var controller: VehicleController
    @Binding var vehicle: Vehicle // El vehículo que estamos editando
    
    @State private var vehicleName: String
    @State private var vehiclePrice: Double
    @State private var vehicleDescription: String
    @State private var vehicleImage: String
    
    init(vehicle: Binding<Vehicle>, controller: VehicleController) {
        _vehicle = vehicle
        _vehicleName = State(initialValue: vehicle.wrappedValue.name)
        _vehiclePrice = State(initialValue: vehicle.wrappedValue.price)
        _vehicleDescription = State(initialValue: vehicle.wrappedValue.description)
        _vehicleImage = State(initialValue: vehicle.wrappedValue.image)
        self.controller = controller
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(vehicleImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 20)
                    .shadow(radius: 10)
                
                TextField("Vehicle Name", text: $vehicleName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
                
                TextField("Price", value: $vehiclePrice, format: .number)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .font(.title2)
                
                TextField("Description", text: $vehicleDescription)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.body)
                    .frame(height: 100)
                
                TextField("Image Name", text: $vehicleImage)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.subheadline)
                
                Button(action: {
                    saveVehicleChanges()
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarTitle("Edit Vehicle", displayMode: .inline)
    }
    
    func saveVehicleChanges() {
        controller.updateVehicle(vehicle: vehicle, newName: vehicleName, newPrice: vehiclePrice, newDescription: vehicleDescription, newImage: vehicleImage)
    }
}

struct VehicleDetailAdminView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailAdminView(vehicle: .constant(Vehicle(name: "Mazda CX-30", price: 100, image: "car1", description: "The Mazda CX-30 is a compact SUV.")), controller: VehicleController())
    }
}
