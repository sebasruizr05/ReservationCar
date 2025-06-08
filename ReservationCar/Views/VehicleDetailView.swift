import SwiftUI

struct VehicleDetailView: View {
    var vehicle: Vehicle
    @ObservedObject var reservationController: ReservationController

    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var numberOfDays = 0

    var body: some View {
        ScrollView {
            VStack {
                Image(vehicle.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 20)
                    .shadow(radius: 10)

                Text(vehicle.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)

                Text("$\(vehicle.price, specifier: "%.2f") per day")
                    .font(.title2)
                    .padding(.bottom, 16)

                Text(vehicle.description)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.bottom, 16)

                VStack {
                    VStack(alignment: .leading) {
                        Text("Select Start Date")
                            .font(.headline)

                        DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(width: 250)
                            .padding(.bottom, 16)
                            .onChange(of: startDate) { _ in
                                calculateNumberOfDays()
                            }
                    }

                    VStack(alignment: .leading) {
                        Text("Select End Date")
                            .font(.headline)
                            .padding(.top, 16)

                        DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(width: 250)
                            .padding(.bottom, 16)
                            .onChange(of: endDate) { _ in
                                calculateNumberOfDays()
                            }
                    }
                }
                .padding(.horizontal)

                Text("Total Days: \(numberOfDays) days")
                    .font(.title2)
                    .padding(.top, 20)

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

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Vehicle Details", displayMode: .inline)
    }

    func calculateNumberOfDays() {
        let calendar = Calendar.current
        let diffComponents = calendar.dateComponents([.day], from: startDate, to: endDate)
        numberOfDays = (diffComponents.day ?? 0) + 1
    }

    func reserveVehicle() {
        let newReservation = Reservation(
            id: UUID().uuidString, // genera un ID único
            userId: "sampleUser",  
            vehicleName: vehicle.name,
            vehicleImage: vehicle.image,
            numberOfDays: numberOfDays,
            status: .pending
        )
        reservationController.addReservation(reservation: newReservation)
    }

}
