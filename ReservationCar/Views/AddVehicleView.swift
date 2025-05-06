import SwiftUI

struct AddVehicleView: View {
    @ObservedObject var vehicleController: VehicleController // Recibe el controlador
    @State private var name = ""
    @State private var price = ""
    @State private var description = ""
    @State private var image = ""

    var body: some View {
        VStack {
            Text("Add Vehicle")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Image", text: $image)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                addVehicle()
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
        .padding()
    }

    func addVehicle() {
        // Validar que el precio sea un número válido
        guard let vehiclePrice = Double(price), !name.isEmpty, !description.isEmpty else {
            // Podrías mostrar un mensaje de error si no se llena correctamente
            return
        }
        
        let newVehicle = Vehicle(name: name, price: vehiclePrice, image: image, description: description)
        vehicleController.addVehicle(vehicle: newVehicle)
    }
}

struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView(vehicleController: VehicleController()) // Pasar controlador para pruebas
    }
}
