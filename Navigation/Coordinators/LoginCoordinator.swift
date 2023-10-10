//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Максим Зиновьев on 17.09.2023.
//

import UIKit

class LoginCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startVC() {
        let profileCoordinator = ProfileCoordinator(navigationController: self.navigationController)
        
        let loginVC = LogInViewController(coordinator: profileCoordinator)
        loginVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 1)
        navigationController.pushViewController(loginVC, animated: true)
    }
}
