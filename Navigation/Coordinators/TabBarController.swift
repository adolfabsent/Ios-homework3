//
//  TabBarController.swift
//  Navigation
//
//  Created by Максим Зиновьев on 13.09.2023.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    private let feedViewController = Factory(flow: .feed)

    private let profileViewController = Factory(flow: .profile)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()
    }

    private func setControllers() {
        viewControllers = [
            feedViewController.navigationController,
            profileViewController.navigationController
        ]
    }
}
