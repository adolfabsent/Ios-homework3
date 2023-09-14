//
//  Checker.swift
//  Navigation
//
//  Created by Максим Зиновьев on 31.08.2023.
//

import UIKit

class Checker {
    static let shared = Checker()

        private init() {}

#if DEBUG
    private let login = testUserService.user.login
#else
    private let login = currentUserService.user.login
#endif
    private let password = "Raymond11"

    func check(login: String, password: String) -> Bool {
        return self.login == login && self.password == password

    }
}

