//
//  LogInViewControllerDelegate.swift
//  Navigation
//
//  Created by Максим Зиновьев on 13.09.2023.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func checkLogin(login: String) -> Bool
       func checkPassword(password: String) -> Bool
}
