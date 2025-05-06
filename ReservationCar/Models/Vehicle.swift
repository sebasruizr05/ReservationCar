import Foundation

struct Vehicle: Identifiable {
    var id = UUID()
    var name: String
    var price: Double
    var image: String
    var description: String
}
