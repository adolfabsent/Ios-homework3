//
//  CustomButton.swift
//  Navigation
//
//  Created by Максим Зиновьев on 07.09.2023.
//

import UIKit

final class CustomButton: UIButton {

    private let title: String
    private let titleColor: UIColor

    var tapAction: (() -> Void)?

    init(title: String, titleColor: UIColor) {
        self.title = title
        self.titleColor = titleColor
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        tapAction?()
    }
}
