import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: TabBarCoordinatorProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let tabBarController = UITabBarController()
        coordinator = TabBarCoordinator(tabBarController: tabBarController)

        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = coordinator?.startApplication()
        downloadData()

    }

    private func downloadData() {
        guard let configuration = AppConfiguration.getArrayURL().randomElement() else { return }

        NetworkService.fetchData(with: configuration) { result in
            switch result {
            case .success(let data):
                let dataString = String(data: data, encoding: .utf8)
                print("--------- Data ---------")
                print(dataString as Any)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



func sceneDidDisconnect(_ scene: UIScene) {


    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
