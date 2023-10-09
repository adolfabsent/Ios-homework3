//
//  FeedModel.swift
//  Navigation
//
//  Created by Максим Зиновьев on 07.09.2023.
//

import Foundation

final class FeedModel {
    
    static let shared = FeedModel()
    
    var secretWord = "Cat"
    
    
    init() {}
    
    func check(word: String) throws -> Bool {
        if secretWord == word {
            return true
        } else if word == "" {
            throw feedError.isEmpty
        } else if secretWord != word {
            throw feedError.unauthorized
        } else {
            throw feedError.notFound
        }
    }
}
