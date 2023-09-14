//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Максим Зиновьев on 13.09.2023.
//

import UIKit

protocol MainCoordinatorProtocol {
    func startApplication() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {
    func startApplication() -> UIViewController {
        return RootTabBarViewController()
    }
}
