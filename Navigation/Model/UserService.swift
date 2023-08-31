//
//  UserService.swift
//  Navigation
//
//  Created by Максим Зиновьев on 29.08.2023.
//

import UIKit

class User {
    var login: String
    var fullName: String
    var avatar: UIImage?
    var status: String

    init(login: String, name: String, avatar: UIImage?, status: String) {
        self.login = login
        self.fullName = name
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    func authorization(login: String) -> User?
}

class CurrentUserService: UserService {
    let user = User(
        login: "Raymond",
        name: "Cat Raymond",
        avatar: UIImage(named: "raymond") ?? nil,
        status: "Looking for Food"
    )
    func authorization(login: String) -> User? {
        return login == user.login ? user : nil
    }
}

class TestUserService: UserService {
    let user = User(
        login: "Lolly",
        name: "Cat Lolly",
        avatar: UIImage(named: "lolly") ?? nil,
        status: "Looking for Sugar"
    )
    func authorization(login: String) -> User? {
        return login == user.login ? user : nil
    }
}

let currentUserService = CurrentUserService()
let testUserService = TestUserService()
