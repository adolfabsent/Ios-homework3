//
//  Factory.swift
//  Navigation
//
//  Created by Максим Зиновьев on 13.09.2023.
//

import UIKit

final class Factory {

    enum Flow {
        case feed
        case profile
    }

    let navigationController: UINavigationController = UINavigationController()
    let flow: Flow

    init(
        flow: Flow
    ) {
        self.flow = flow
        startModule()
    }

    func startModule() {
        switch flow {
        case .feed:
            let feedCoordinator = FeedCoordinator()
            let controller = FeedViewController(.systemGray6, "Лента", parent: navigationController)
            feedCoordinator.navController = navigationController
            navigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)
        case .profile:
            let profileCoordinator = ProfileCoordinator()
            let controller = LogInViewController()
            profileCoordinator.navController = navigationController
            navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "house"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}
