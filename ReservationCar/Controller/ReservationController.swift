import Foundation

class ReservationController: ObservableObject {
    @Published var reservations: [Reservation] = [
        Reservation(vehicleName: "Mazda CX-30", vehicleImage: "car1", startDate: Date(), endDate: Date().addingTimeInterval(86400), status: .pending, customerName: "John Doe"),
        Reservation(vehicleName: "Lexus RX", vehicleImage: "car2", startDate: Date(), endDate: Date().addingTimeInterval(86400), status: .pending, customerName: "Jane Smith")
    ]
    
    // Función para agregar una nueva reserva
    func addReservation(reservation: Reservation) {
        reservations.append(reservation)
    }
    
    // Función para eliminar una reserva
    func deleteReservation(at offsets: IndexSet) {
        reservations.remove(atOffsets: offsets)
    }
    
    // Función para actualizar una reserva
    func updateReservation(reservation: Reservation, newStatus: ReservationStatus) {
        if let index = reservations.firstIndex(where: { $0.id == reservation.id }) {
            reservations[index].status = newStatus
        }
    }
}
