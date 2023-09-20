//
//  TabBarProtocol.swift
//  Navigation
//
//  Created by Максим Зиновьев on 17.09.2023.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    var tabBarController: UITabBarController { get set }

    func startApplication() -> UIViewController
}
