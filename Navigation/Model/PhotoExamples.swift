//
//  Photos.swift
//  Navigation
//
//  Created by Максим Зиновьев on 15.08.2023.
//

import UIKit

final class Photos {


    static let shared = Photos()

    let examples: [UIImage]

    private init() {
        var photos = [UIImage]()
        for i in 1...20 { photos.append((UIImage(named: "\(i)") ?? UIImage())) }
        examples = photos.shuffled()

    }

}
