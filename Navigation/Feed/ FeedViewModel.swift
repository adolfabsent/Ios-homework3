//
//   FeedViewModel.swift
//  Navigation
//
//  Created by Максим Зиновьев on 12.09.2023.
//

import UIKit


protocol FeedViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((FeedViewModel.State) -> Void)? { get set }
    func updateState(viewInput: FeedViewModel.ViewInput)

}

final class FeedViewModel: FeedViewModelProtocol {
    enum State {
        case initial
        case correctly
        case wrong
    }

    enum ViewInput {
        case checkGuessButtonDidTap(word: String)
        case buttonDidTap
    }

    weak var coordinator: FeedCoordinator?
        var onStateDidChange: ((State) -> Void)?



    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }

    private let feedModel: FeedModelProtocol

    init(feedModel: FeedModelProtocol) {
        self.feedModel = feedModel
    }

    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .checkGuessButtonDidTap(word: let word):
                if feedModel.check(word: word) {
                    self.state = .correctly
            } else {
                self.state = .wrong
            }
        case .buttonDidTap: break
        }
    }
}
