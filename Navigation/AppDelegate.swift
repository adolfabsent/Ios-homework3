

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

       func application(_ application: UIApplication,
                        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

           let loginVC = LogInViewController()
           let profileNC = UINavigationController(rootViewController: loginVC)
           profileNC.tabBarItem = UITabBarItem(title: "Profile",
                                               image: UIImage(systemName: "person.crop.circle"),
                                               selectedImage: UIImage(systemName: "person.crop.circle.fill"))

           let feedVC = FeedViewController()
           let feedNC = UINavigationController(rootViewController: feedVC)
           feedNC.tabBarItem = UITabBarItem(title: "Feed",
                                            image: UIImage(systemName: "text.bubble"),
                                            selectedImage: UIImage(systemName: "text.bubble.fill"))

           let tabBarController = UITabBarController()
           tabBarController.tabBar.backgroundColor = .white
           tabBarController.viewControllers = [profileNC, feedNC]

         
           window = UIWindow(frame: UIScreen.main.bounds)
           window?.rootViewController = tabBarController
           window?.makeKeyAndVisible()

           return true
       }
   }
