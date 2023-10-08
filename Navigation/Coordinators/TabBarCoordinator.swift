//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by Максим Зиновьев on 17.09.2023.
//

import UIKit

class TabBarCoordinator: TabBarCoordinatorProtocol {
    var tabBarController: UITabBarController

    var coordinatorNavFeed: CoordinatorProtocol?
    var coordinatorNavProfile: CoordinatorProtocol?
    var loginCoordinator: CoordinatorProtocol?

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController

    }

    func startApplication() -> UIViewController {
        let navFeedController = UINavigationController()
        coordinatorNavFeed = FeedCoordinator(navigationController: navFeedController)
        coordinatorNavFeed?.startVC()
        let feed = coordinatorNavFeed!

        let navProfileController = UINavigationController()

        loginCoordinator = LoginCoordinator(navigationController: navProfileController)
        loginCoordinator?.startVC()
        let profile = loginCoordinator!

        tabBarController.viewControllers = [feed.navigationController, profile.navigationController]

        return self.tabBarController
    }
}
