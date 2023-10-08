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

    func startVC() {
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

    func showAlert(error: Errors) {
          var alertMessage = ""

          switch error {
          case .loginIsEmpty:
              alertMessage = "Введите логин"
          case .passIsEmpty:
              alertMessage = "Введите пароль"
          case .incorrectLogin:
              alertMessage = "Введён неверный логин"
          case .incorrectPass:
              alertMessage = "Введён неверный пароль"
          }

          let alertController = UIAlertController(title: "Ошибка!", message: alertMessage, preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default) { _ in
              print("OK")
          }
          alertController.addAction(okAction)
          navigationController.present(alertController, animated: true, completion: nil)
      }
}
