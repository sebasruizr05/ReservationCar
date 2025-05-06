import SwiftUI

struct VehicleManagementView: View {
    @ObservedObject var vehicleController = VehicleController() // Controlador de vehículos
    
    @State private var showAddVehicle = false // Para mostrar la vista de agregar vehículo
    @State private var showEditVehicle = false // Para mostrar la vista de editar vehículo
    @State private var selectedVehicle: Vehicle? = nil // Para almacenar el vehículo seleccionado
    
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
                        showEditVehicle.toggle()
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            vehicleController.deleteVehicle(at: IndexSet([vehicleController.vehicles.firstIndex(where: { $0.id == vehicle.id }) ?? 0])) // Elimina el vehículo de la lista
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
                .onDelete(perform: deleteVehicle)
            }
            
            Button(action: {
                showAddVehicle.toggle()
            }) {
                Text("Add Vehicle")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $showAddVehicle) {
            AddVehicleView(vehicleController: vehicleController) // Presenta la vista de agregar vehículo
        }
        .sheet(isPresented: $showEditVehicle, onDismiss: nil) {
            if let selectedVehicle = selectedVehicle {
                VehicleEditView(vehicle: selectedVehicle, vehicleController: vehicleController)
            }
        }
    }
    
    func deleteVehicle(at offsets: IndexSet) {
        vehicleController.deleteVehicle(at: offsets) // Llama al método del controlador para eliminar el vehículo
    }
}

struct VehicleManagementView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleManagementView()
    }
}
