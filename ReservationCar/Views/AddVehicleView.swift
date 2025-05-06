import SwiftUI

struct AddVehicleView: View {
    @ObservedObject var vehicleController: VehicleController
    @State private var name = ""
    @State private var price = ""
    @State private var description = ""
    @State private var image = "" // Esta variable guardará la imagen seleccionada
    @State private var selectedImage: UIImage? = nil // Imagen seleccionada
    @State private var showImagePicker: Bool = false // Mostrar ImagePicker
    
    var body: some View {
        VStack {
            Text("Add Vehicle")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)
            } else {
                Image(systemName: "photo.on.rectangle.angled") // Ícono si no hay imagen
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)
            }
            
            // Botón para seleccionar imagen
            Button("Select Image") {
                showImagePicker.toggle()
            }
            .padding()
            .foregroundColor(.blue)
            
            // Nombre del vehículo
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Precio del vehículo
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Descripción del vehículo
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Agregar vehículo
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
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage) // Mostrar ImagePicker para seleccionar imagen
        }
    }

    func addVehicle() {
        // Validar que el precio sea un número válido
        guard let vehiclePrice = Double(price), !name.isEmpty, !description.isEmpty else {
            return
        }
        
        // Si no se ha seleccionado imagen, usar un nombre predeterminado
        let vehicleImage = selectedImage != nil ? "\(UUID()).jpg" : "default_image.jpg"
        
        // Crear un nuevo vehículo y agregarlo al controlador
        let newVehicle = Vehicle(name: name, price: vehiclePrice, image: vehicleImage, description: description)
        vehicleController.addVehicle(vehicle: newVehicle)
    }
}

struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView(vehicleController: VehicleController())
    }
}
