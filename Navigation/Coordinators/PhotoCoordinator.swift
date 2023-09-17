//
//  PhotoCoordinator.swift
//  Navigation
//
//  Created by Максим Зиновьев on 17.09.2023.
//

import UIKit

class PhotoCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startView() {
        let photoViewController = PhotosViewController()
        photoViewController.title = "Photo Gallery"

        navigationController.pushViewController(photoViewController, animated: true)
    }
}
