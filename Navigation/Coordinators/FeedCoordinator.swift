//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Максим Зиновьев on 12.09.2023.
//

import UIKit

class FeedCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startVC() {
        let feedVC = FeedViewController(coordinator: self)
        feedVC.view.backgroundColor = .white
        feedVC.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "newspaper"), tag: 0)

        navigationController.pushViewController(feedVC, animated: true)
    }

    func toPostViewController(send post: Post) {
        let postVC = PostViewController( nibName: nil, bundle: nil)
        postVC.post = post

        navigationController.pushViewController(postVC, animated: true)
    }
}
