import SwiftUI

struct VehicleDetailView: View {
    var vehicle: Vehicle
    @ObservedObject var reservationController: ReservationController // Recibir el controlador
    
    @State private var startDate = Date() // Fecha de inicio de la reserva
    @State private var endDate = Date()   // Fecha de fin de la reserva
    @State private var numberOfDays = 0   // Número de días de la reserva
    
    var body: some View {
        ScrollView { // Permite el desplazamiento si es necesario
            VStack {
                // Imagen del vehículo
                Image(vehicle.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200) // Tamaño ajustado
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 20)
                    .shadow(radius: 10)
                
                // Detalles del vehículo
                Text(vehicle.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                
                Text("$\(vehicle.price, specifier: "%.2f") per day")
                    .font(.title2)
                    .padding(.bottom, 16)
                
                // Descripción del vehículo
                Text(vehicle.description) // Aquí se muestra la descripción
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                
                // Sección de fechas
                VStack {
                    // Fecha de inicio
                    VStack(alignment: .leading) {
                        Text("Select Start Date")
                            .font(.headline)
                        
                        DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(width: 250) // Tamaño ajustado
                            .padding(.bottom, 16)
                            .onChange(of: startDate) { _ in
                                calculateNumberOfDays() // Calcular días cuando la fecha de inicio cambia
                            }
                    }
                    
                    // Fecha de fin
                    VStack(alignment: .leading) {
                        Text("Select End Date")
                            .font(.headline)
                            .padding(.top, 16)
                        
                        DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(width: 250) // Tamaño ajustado
                            .padding(.bottom, 16)
                            .onChange(of: endDate) { _ in
                                calculateNumberOfDays() // Calcular días cuando la fecha de fin cambia
                            }
                    }
                }
                .padding(.horizontal)
                
                // Mostrar la cantidad de días de la reserva
                Text("Total Days: \(numberOfDays) days")
                    .font(.title2)
                    .padding(.top, 20)
                
                // Botón para realizar la reserva
                Button(action: {
                    reserveVehicle()
                }) {
                    Text("Reserve Now")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                Spacer() // Asegura que los elementos estén alineados correctamente en la parte superior
            }
            .padding()
        }
        .navigationBarTitle("Vehicle Details", displayMode: .inline)
    }
    
    // Función para calcular el número de días entre las fechas seleccionadas
    func calculateNumberOfDays() {
        let calendar = Calendar.current
        let diffComponents = calendar.dateComponents([.day], from: startDate, to: endDate)
        numberOfDays = diffComponents.day ?? 0 // Calcula los días de diferencia entre las fechas
    }
    
    // Función para realizar la reserva
    func reserveVehicle() {
        print("Vehicle reserved for \(numberOfDays) days.")
        let newReservation = Reservation(vehicleName: vehicle.name,
                                         vehicleImage: vehicle.image, // Aquí pasamos la imagen del vehículo
                                         startDate: startDate,
                                         endDate: endDate,
                                         status: .pending,
                                         customerName: "User") // Aquí deberías usar el nombre real del cliente
        reservationController.addReservation(reservation: newReservation)
    }
}
