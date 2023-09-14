//
//  LoginInspector.swift
//  Navigation
//
//  Created by Максим Зиновьев on 31.08.2023.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}

protocol LoginFactory {

    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {

    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }


}
