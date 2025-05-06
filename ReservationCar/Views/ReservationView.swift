import SwiftUI

struct ReservationView: View {
    @State private var reservations: [Reservation] = [
        Reservation(vehicleName: "Mazda CX-30", vehicleImage: "car1", startDate: Date(), endDate: Date().addingTimeInterval(86400), status: .pending, customerName: "John Doe"),
        Reservation(vehicleName: "Lexus RX", vehicleImage: "car2", startDate: Date().addingTimeInterval(172800), endDate: Date().addingTimeInterval(259200), status: .inProgress, customerName: "Jane Smith")
    ]
    
    var body: some View {
        VStack {
            Text("Manage Reservations")
                .font(.title)
                .padding()
            
            List {
                ForEach(reservations) { reservation in
                    VStack(alignment: .leading) {
                        Text(reservation.vehicleName)
                            .font(.headline)
                        
                        Text("Customer: \(reservation.customerName)")
                            .font(.subheadline)
                        
                        Text("Status: \(reservation.status.rawValue.capitalized)")
                            .foregroundColor(reservation.status == .pending ? .orange : .green)
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
