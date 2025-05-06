import SwiftUI

struct UserReservationView: View {
    @ObservedObject var reservationController: ReservationController
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Reservations")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                List(reservationController.reservations) { reservation in
                    HStack {
                        // Imagen del vehículo
                        Image(reservation.vehicleImage) // Asegúrate de que vehicleImage esté en tu modelo de reserva
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            // Nombre del vehículo
                            Text(reservation.vehicleName)
                                .font(.headline)
                            
                            // Mostrar la cantidad de días de la reserva
                            Text("Days: \(reservation.numberOfDays)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        // Mostrar el estado de la reserva
                        Text(reservation.status.rawValue)
                            .foregroundColor(reservation.status == .pending ? .orange : .green)
                            .font(.subheadline)
                    }
                }
                .navigationBarTitle("Reservations", displayMode: .inline)
            }
        }
    }
}

struct UserReservationView_Previews: PreviewProvider {
    static var previews: some View {
        UserReservationView(reservationController: ReservationController())
    }
}
