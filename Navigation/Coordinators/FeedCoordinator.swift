//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Максим Зиновьев on 12.09.2023.
//

import UIKit

class FeedCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController

    enum Presentation {
        case post
        case info
        case autorized
        case error(feedError)
        case attention
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startVC() {
        let feedModel = FeedModel()
        let feedVC = FeedViewController(coordinator: self, viewModel: feedModel)
        feedVC.view.backgroundColor = .white
        feedVC.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "newspaper"), tag: 0)

        navigationController.pushViewController(feedVC, animated: true)
    }

    func toPostViewController(send post: Post) {
        let postVC = PostViewController( nibName: nil, bundle: nil)
        postVC.post = post

        navigationController.pushViewController(postVC, animated: true)
    }

    func present(_ presentation: Presentation) {
        switch presentation {
        case .post:
            let postViewController = PostViewController()
            navigationController.pushViewController(postViewController, animated: true)
        case .info:
            let infoViewController = InfoViewController()
            navigationController.present(infoViewController, animated: true, completion: nil)
        case .autorized:
            let alertController = UIAlertController(title: "Внимание", message: "Пароль верный", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "ОК", style: .default)
            let cancelBtn = UIAlertAction(title: "Отмена", style: .cancel)
            alertController.addAction(okBtn)
            alertController.addAction(cancelBtn)
            navigationController.present(alertController, animated: true)
        case .error(let apiError):
            var message = ""
            switch apiError {
            case .isEmpty:
                message = "Пустое поле, заполните!"
            case .unauthorized:
                message = "Вы не угадали!"
            case .notFound:
                message = "Не найден"
            }
            let alertController = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "ОК", style: .default)
            let cancelBtn = UIAlertAction(title: "Отмена", style: .cancel)
            alertController.addAction(okBtn)
            alertController.addAction(cancelBtn)
            navigationController.present(alertController, animated: true)
            case .attention:
            let alertController = UIAlertController(title: "Внимание", message: "Кря кря кря", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "Кря (в консоль)", style: .default) { _ in print("Кря кря") }
            let cancelBtn = UIAlertAction(title: "Бред", style: .cancel)
            alertController.addAction(okBtn)
            alertController.addAction(cancelBtn)
            guard let viewController = navigationController.presentedViewController else { return }
            viewController.present(alertController, animated: true)
        }
    }
}
