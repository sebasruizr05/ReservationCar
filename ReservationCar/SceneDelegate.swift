import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            // Asegúrate de que estamos utilizando el UIWindowScene
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            // Crear la ventana para la escena
            window = UIWindow(windowScene: windowScene)
            
            // Establecer StartView como la vista inicial
            let welcomeView = WelcomeView()
            
            // Asignar StartView a la ventana usando un UIHostingController
            window?.rootViewController = UIHostingController(rootView: welcomeView)
            window?.makeKeyAndVisible()
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Llamado cuando la escena es liberada por el sistema.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Llamado cuando la escena se mueve de inactiva a activa.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Llamado cuando la escena pasará a estado inactivo.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Llamado cuando la escena pasa al primer plano desde el fondo.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Llamado cuando la escena pasa al fondo.
    }
}
