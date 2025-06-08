import FirebaseStorage
import UIKit

class ImageUploadService {
    static func uploadProfileImage(_ image: UIImage, for userID: String, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = Storage.storage().reference().child("profile_images/\(userID).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return completion(.failure(NSError(domain: "Invalid image data", code: 0)))
        }

        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let downloadURL = url {
                    completion(.success(downloadURL.absoluteString))
                }
            }
        }
    }
}
