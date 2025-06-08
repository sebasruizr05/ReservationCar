import Foundation

struct Vehicle: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var price: Double
    var image: String // ← usamos imagen local
    var description: String
}
