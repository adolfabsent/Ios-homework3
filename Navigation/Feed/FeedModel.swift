//
//  FeedModel.swift
//  Navigation
//
//  Created by Максим Зиновьев on 07.09.2023.
//

import Foundation

protocol FeedModelProtocol: AnyObject {
    func check(word: String) -> Bool
}

class FeedModel: FeedModelProtocol {

    let secretWord: String = "Cat"

    func check(word: String) -> Bool {
        return word == secretWord
    }
}
