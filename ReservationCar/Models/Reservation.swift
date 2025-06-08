import Foundation

enum ReservationStatus: String, Codable {
    case pending
    case confirmed
    case rejected
}

struct Reservation: Identifiable, Codable {
    var id: String
    var userId: String
    var vehicleName: String
    var vehicleImage: String
    var numberOfDays: Int
    var status: ReservationStatus
}
