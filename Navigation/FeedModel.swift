//
//  FeedModel.swift
//  Navigation
//
//  Created by Максим Зиновьев on 07.09.2023.
//

import Foundation

class FeedModel {

    let secretWord: String = "Cat"

    func check(_ word: String) -> Bool {
        return word == secretWord
    }
}
