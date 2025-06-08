import SwiftUI

struct VehicleCell: View {
    var vehicle: Vehicle

    var body: some View {
        HStack {
            Image(vehicle.image) // ← antes era vehicle.image
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text(vehicle.name)
                    .font(.headline)

                Text("$\(vehicle.price, specifier: "%.2f") per day")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}
