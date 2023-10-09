//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Максим Зиновьев on 17.09.2023.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func startVC()
}
