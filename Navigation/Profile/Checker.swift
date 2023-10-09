//
//  Checker.swift
//  Navigation
//
//  Created by Максим Зиновьев on 31.08.2023.
//

import UIKit

struct Checker {
    static let shared = Checker()
    let login = "Raymond"
    let password = "Raymond11"

    private init() {}

    //#if DEBUG
    //  private let login = testUserService.user.login
    //#else
    //  private let login = currentUserService.user.login
    //#endif

    func check(login: String?, password: String?) -> Bool {
        return self.login == login && self.password == password

    }
}
