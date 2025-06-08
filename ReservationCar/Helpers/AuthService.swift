import FirebaseAuth
import FirebaseFirestore

typealias FirebaseUser = FirebaseAuth.User

class AuthService: ObservableObject {
    static let shared = AuthService()
    private init() {}

    @Published var user: FirebaseUser?

    // Registro de usuario (rol fijo como "client")
    func signUp(name: String, cedula: String, email: String, password: String, completion: @escaping (Result<FirebaseUser, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([
                    "name": name,
                    "cedula": cedula,
                    "email": email,
                    "role": "client"
                ]) { firestoreError in
                    if let firestoreError = firestoreError {
                        completion(.failure(firestoreError))
                    } else {
                        DispatchQueue.main.async {
                            self.user = user
                            completion(.success(user))
                        }
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    // Inicio de sesión y lectura de rol desde Firestore
    func signIn(email: String, password: String, completion: @escaping (Result<(FirebaseUser, String), Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).getDocument { snapshot, error in
                    if let data = snapshot?.data(), let role = data["role"] as? String {
                        DispatchQueue.main.async {
                            self.user = user
                            completion(.success((user, role)))
                        }
                    } else {
                        completion(.failure(error ?? NSError(domain: "No role found", code: 0)))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        self.user = nil
    }
}
