//
//  FeedModel.swift
//  Navigation
//
//  Created by Максим Зиновьев on 07.09.2023.
//

import Foundation

final class FeedModel {

    static let shared = FeedModel()

    private let secretWord = "Cat"


     init() {}

    func check(word: String?) -> Bool {

        guard let word = word, !word.isEmpty else {
            return false
        }

        return word == secretWord
    }
}
