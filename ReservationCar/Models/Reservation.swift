import Foundation

struct Reservation: Identifiable {
    var id = UUID()
    var vehicleName: String
    var vehicleImage: String // Imagen del vehículo (corrige el orden)
    var startDate: Date
    var endDate: Date
    var status: ReservationStatus
    var customerName: String
    var numberOfDays: Int { // Calcula los días de la reserva
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
}

enum ReservationStatus: String {
    case pending = "Pending"
    case inProgress = "In Progress"
    case completed = "Completed"
    case approved = "Approved"
}
