//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Максим Зиновьев on 15.08.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {


    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .black
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var arrowImageView: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrow
    }()

    var stackViewImage: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()

    func firstPreviewImage(index: Int) -> UIImageView {
        let preview = UIImageView()
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.image = Photos.shared.examples[index]
        preview.contentMode = .scaleAspectFill
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        return preview
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(collectionLabel, arrowImageView, stackViewImage)
        setupPreviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPreviews() {
        for ind in 0...2 {
            let image = firstPreviewImage(index: ind)
            stackViewImage.addArrangedSubview(image)
            NSLayoutConstraint.activate([
                image.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
                image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.56),
            ])
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indentTwelve),
            collectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            collectionLabel.widthAnchor.constraint(equalToConstant: 80),
            collectionLabel.heightAnchor.constraint(equalToConstant: 40),

            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentTwelve),
            arrowImageView.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 40),
            arrowImageView.widthAnchor.constraint(equalToConstant: 40),

            stackViewImage.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: LayoutConstants.indentTwelve),
            stackViewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            stackViewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentTwelve),
            stackViewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indentTwelve),
        ])
    }
}
