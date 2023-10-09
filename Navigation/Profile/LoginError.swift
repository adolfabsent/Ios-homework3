//
//  LoginError.swift
//  Navigation
//
//  Created by Максим Зиновьев on 02.10.2023.
//

import Foundation

enum loginError: Error {
    case incorrectLogin
    case incorrectPass
    case loginIsEmpty
    case passIsEmpty
}

enum feedError: Error {
    case unauthorized
    case notFound
    case isEmpty
}
