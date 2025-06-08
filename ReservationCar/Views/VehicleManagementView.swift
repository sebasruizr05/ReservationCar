import SwiftUI

struct VehicleManagementView: View {
    @ObservedObject var vehicleController = VehicleController()
    
    @State private var showAddVehicle = false
    @State private var showEditVehicle = false
    @State private var selectedVehicle: Vehicle? = nil

    var body: some View {
        VStack {
            Text("Manage Vehicles")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            List {
                ForEach(vehicleController.vehicles) { vehicle in
                    HStack {
                        Image(vehicle.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        Text(vehicle.name)
                            .font(.headline)

                        Spacer()

                        Text("$\(vehicle.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        selectedVehicle = vehicle
                        showEditVehicle = true
                    }
                }
                .onDelete(perform: deleteVehicle)
            }

            Button("Add Vehicle") {
                showAddVehicle = true
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .sheet(isPresented: $showAddVehicle) {
            AddVehicleView(vehicleController: vehicleController)
        }
        .sheet(isPresented: $showEditVehicle) {
            if let vehicleToEdit = selectedVehicle {
                VehicleEditView(vehicle: vehicleToEdit, vehicleController: vehicleController)
            }
        }
    }

    func deleteVehicle(at offsets: IndexSet) {
        vehicleController.deleteVehicle(at: offsets)
    }
}

struct VehicleManagementView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleManagementView()
    }
}
