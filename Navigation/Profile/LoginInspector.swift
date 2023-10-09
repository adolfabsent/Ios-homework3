//
//  LoginInspector.swift
//  Navigation
//
//  Created by Максим Зиновьев on 31.08.2023.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func checkLogin(login: String) -> Bool {
        return Checker.shared.check(login: login, password: nil)
    }
    
    func checkPassword(password: String) -> Bool {
        return Checker.shared.check(login: nil, password: password)
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
