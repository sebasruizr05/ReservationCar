import SwiftUI
import FirebaseFirestore

struct ReservationView: View {
    @State private var reservations: [Reservation] = []
    @State private var isLoading = true

    @State private var selectedReservation: Reservation?
    @State private var showConfirmationDialog = false

    var body: some View {
        VStack {
            Text("Manage Reservations")
                .font(.title)
                .padding()

            if isLoading {
                ProgressView()
            } else if reservations.isEmpty {
                Text("No pending reservations.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(reservations) { reservation in
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Vehicle: \(reservation.vehicleName)")
                                .font(.headline)

                            Text("Days: \(reservation.numberOfDays)")
                                .font(.subheadline)

                            Text("Status: \(reservation.status.rawValue.capitalized)")
                                .foregroundColor(reservation.status == .pending ? .orange : .green)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 8)
                        .onTapGesture {
                            selectedReservation = reservation
                            showConfirmationDialog = true
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            fetchPendingReservations()
        }
        .confirmationDialog("Manage Reservation", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            if let reservation = selectedReservation {
                Button("Accept", role: .none) {
                    updateStatus(for: reservation, to: .confirmed)
                }

                Button("Reject", role: .destructive) {
                    updateStatus(for: reservation, to: .rejected)
                }

                Button("Cancel", role: .cancel) {}
            }
        }
    }

    func fetchPendingReservations() {
        isLoading = true
        let db = Firestore.firestore()

        db.collection("reservations")
            .whereField("status", isEqualTo: "pending")
            .getDocuments { snapshot, error in
                isLoading = false
                if let error = error {
                    print("Error fetching reservations: \(error.localizedDescription)")
                    return
                }

                self.reservations = snapshot?.documents.compactMap { doc in
                    let data = doc.data()

                    guard let userId = data["userId"] as? String,
                          let vehicleName = data["vehicleName"] as? String,
                          let vehicleImage = data["vehicleImage"] as? String,
                          let numberOfDays = data["numberOfDays"] as? Int,
                          let statusString = data["status"] as? String,
                          let status = ReservationStatus(rawValue: statusString) else {
                        return nil
                    }

                    return Reservation(
                        id: doc.documentID,
                        userId: userId,
                        vehicleName: vehicleName,
                        vehicleImage: vehicleImage,
                        numberOfDays: numberOfDays,
                        status: status
                    )
                } ?? []
            }
    }

    func updateStatus(for reservation: Reservation, to newStatus: ReservationStatus) {
        let db = Firestore.firestore()
        db.collection("reservations").document(reservation.id).updateData([
            "status": newStatus.rawValue
        ]) { error in
            if let error = error {
                print("Error updating status: \(error.localizedDescription)")
            } else {
                print("Reservation \(reservation.id) updated to \(newStatus.rawValue)")
                fetchPendingReservations()
            }
        }
    }
}
