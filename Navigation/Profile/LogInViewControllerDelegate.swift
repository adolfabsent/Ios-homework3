//
//  LogInViewControllerDelegate.swift
//  Navigation
//
//  Created by Максим Зиновьев on 13.09.2023.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}
