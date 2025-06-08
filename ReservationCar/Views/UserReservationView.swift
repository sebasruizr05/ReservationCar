import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserReservationView: View {
    @State private var reservations: [Reservation] = []
    @State private var isLoading = true
    @State private var showStatusAlert = false
    @State private var alertMessage = ""
    @State private var notifiedReservationIds: Set<String> = []
    
    @State private var selectedReservation: Reservation?
    @State private var showDetailSheet = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Your Reservations")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                if isLoading {
                    ProgressView()
                } else if reservations.isEmpty {
                    Text("No reservations found.")
                        .foregroundColor(.gray)
                } else {
                    List(reservations) { reservation in
                        Button(action: {
                            selectedReservation = reservation
                            showDetailSheet = true
                        }) {
                            HStack {
                                Image(reservation.vehicleImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading) {
                                    Text(reservation.vehicleName)
                                        .font(.headline)

                                    Text("Days: \(reservation.numberOfDays)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Text(reservation.status.rawValue.capitalized)
                                    .foregroundColor(reservation.status == .pending ? .orange : .green)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Reservations", displayMode: .inline)
            .onAppear {
                fetchReservations()
            }
            .alert(isPresented: $showStatusAlert) {
                Alert(title: Text("Status Updated"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
            }
            .sheet(item: $selectedReservation) { reservation in
                ReservationDetailSheet(reservation: reservation)
            }
        }
    }

    func fetchReservations() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No authenticated user.")
            return
        }

        let db = Firestore.firestore()
        db.collection("reservations")
            .whereField("userId", isEqualTo: userID)
            .getDocuments { snapshot, error in
                isLoading = false
                if let error = error {
                    print("Error fetching reservations: \(error.localizedDescription)")
                } else {
                    let fetched: [Reservation] = snapshot?.documents.compactMap { doc in
                        let data = doc.data()

                        guard let userId = data["userId"] as? String,
                              let vehicleName = data["vehicleName"] as? String,
                              let vehicleImage = data["vehicleImage"] as? String,
                              let numberOfDays = data["numberOfDays"] as? Int,
                              let statusString = data["status"] as? String,
                              let status = ReservationStatus(rawValue: statusString) else {
                            print("❌ Datos inválidos en doc \(doc.documentID)")
                            return nil
                        }

                        let reservation = Reservation(
                            id: doc.documentID,
                            userId: userId,
                            vehicleName: vehicleName,
                            vehicleImage: vehicleImage,
                            numberOfDays: numberOfDays,
                            status: status
                        )

                        if status != .pending && !notifiedReservationIds.contains(doc.documentID) {
                            notifiedReservationIds.insert(doc.documentID)
                            alertMessage = "Your reservation for '\(vehicleName)' was \(status.rawValue.uppercased())."
                            showStatusAlert = true
                        }

                        return reservation
                    } ?? []

                    self.reservations = fetched
                }
            }
    }
}

struct ReservationDetailSheet: View {
    let reservation: Reservation

    var body: some View {
        VStack(spacing: 20) {
            Image(reservation.vehicleImage)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()

            Text(reservation.vehicleName)
                .font(.title)
                .fontWeight(.bold)

            Text("Number of Days: \(reservation.numberOfDays)")
                .font(.headline)

            Text(statusMessage(for: reservation.status))
                .font(.body)
                .foregroundColor(.blue)
                .padding()

            Spacer()
        }
        .padding()
    }

    func statusMessage(for status: ReservationStatus) -> String {
        switch status {
        case .confirmed:
            return "Your reservation has been accepted. You can now pick up the vehicle."
        case .rejected:
            return "Your reservation was denied."
        case .pending:
            return "Pending confirmation."
        }
    }
}
