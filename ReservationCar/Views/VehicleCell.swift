import SwiftUI

struct VehicleCell: View {
    var vehicle: Vehicle
    
    var body: some View {
        HStack {
            Image(vehicle.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
                .padding()
            
            VStack(alignment: .leading) {
                Text(vehicle.name)
                    .font(.headline)
                Text("$\(vehicle.price, specifier: "%.2f") per day")
                    .font(.subheadline)
            }
        }
    }
}
