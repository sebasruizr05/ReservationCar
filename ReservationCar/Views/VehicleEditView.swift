import SwiftUI

struct VehicleEditView: View {
    @State var vehicle: Vehicle
    @ObservedObject var vehicleController: VehicleController
    
    @State private var newName: String
    @State private var newPrice: Double
    @State private var newDescription: String
    @State private var newImage: String
    
    @State private var showImagePicker: Bool = false // Mostrar ImagePicker
    @State private var selectedImage: UIImage? = nil // Imagen seleccionada
    
    init(vehicle: Vehicle, vehicleController: VehicleController) {
        _vehicle = State(initialValue: vehicle)
        _newName = State(initialValue: vehicle.name)
        _newPrice = State(initialValue: vehicle.price)
        _newDescription = State(initialValue: vehicle.description)
        _newImage = State(initialValue: vehicle.image)
        self.vehicleController = vehicleController
    }
    
    var body: some View {
        VStack {
            // Mostrar la imagen del vehículo, si no se selecciona una nueva, muestra la imagen predeterminada
            if let selectedImage = selectedImage ?? UIImage(named: vehicle.image) {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)
            }
            
            // Botón para seleccionar nueva imagen
            Button("Change Image") {
                showImagePicker.toggle()
            }
            .padding()
            .foregroundColor(.blue)
            
            Text("Edit Vehicle")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            TextField("Name", text: $newName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Price", value: $newPrice, formatter: NumberFormatter())
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $newDescription)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Image", text: $newImage)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                vehicleController.updateVehicle(vehicle: vehicle, newName: newName, newPrice: newPrice, newDescription: newDescription, newImage: newImage)
            }) {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage) // Mostrar ImagePicker para seleccionar imagen
        }
    }
}

struct VehicleEditView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleEditView(vehicle: Vehicle(name: "Mazda CX-30", price: 100, image: "car1", description: "The Mazda CX-30 is a compact SUV with a sleek and dynamic design, ideal for both city driving and adventure."), vehicleController: VehicleController())
    }
}
