import Foundation

class ReservationController: ObservableObject {
    @Published var reservations: [Reservation] = [
        Reservation(
            id: UUID().uuidString,
            userId: "demo-user-1",
            vehicleName: "Mazda CX-30",
            vehicleImage: "car1",
            numberOfDays: 1,
            status: .pending
        ),
        Reservation(
            id: UUID().uuidString,
            userId: "demo-user-2",
            vehicleName: "Lexus RX",
            vehicleImage: "car2",
            numberOfDays: 1,
            status: .pending
        )
    ]
    
    func addReservation(reservation: Reservation) {
        reservations.append(reservation)
    }
    
    func deleteReservation(at offsets: IndexSet) {
        reservations.remove(atOffsets: offsets)
    }
    
    func updateReservation(reservation: Reservation, newStatus: ReservationStatus) {
        if let index = reservations.firstIndex(where: { $0.id == reservation.id }) {
            reservations[index].status = newStatus
        }
    }
}
