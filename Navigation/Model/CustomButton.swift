//
//  CustomButton.swift
//  Navigation
//
//  Created by Максим Зиновьев on 07.09.2023.
//

import UIKit

class CustomButton: UIButton {

    var buttonTap: ((_: UIButton?) -> Void)!

    init(title: String, titleColor: UIColor, backgroundColor: UIColor, buttonTap: @escaping (_: UIButton?) -> Void) {
            super.init(frame: .zero)

            self.setTitle(title, for: .normal)
            self.setTitleColor(titleColor, for: .normal)
            self.backgroundColor = backgroundColor
            self.buttonTap = buttonTap
            self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
           if (buttonTap != nil) {
               self.buttonTap(self)
           }
       }
}
