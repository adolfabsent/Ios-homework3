//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Максим Зиновьев on 13.09.2023.
//

import UIKit

class ProfileCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var user: User?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let currentUserService = CurrentUserService()
        let photoCoordinator = PhotoCoordinator(navigationController: navigationController)
        let profileViewModel = ProfileViewModel(user: self.user!)

        let profileVC = ProfileViewController(
            user: user!, photoCoordinator: photoCoordinator,
             profileViewModel: profileViewModel
        )

        navigationController.pushViewController(profileVC, animated: true)
    }

    func setUser(user: User) {
        self.user = user
    }
}
