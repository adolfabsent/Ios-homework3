//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Максим Зиновьев on 15.08.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var photoGalleryImages: UIImageView = {
        let photoGalleryImages = UIImageView()
        photoGalleryImages.layer.cornerRadius = 6
        photoGalleryImages.clipsToBounds = true
        photoGalleryImages.translatesAutoresizingMaskIntoConstraints = false
        return photoGalleryImages
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoGalleryImages)
        NSLayoutConstraint.activate([
            photoGalleryImages.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            photoGalleryImages.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            photoGalleryImages.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            photoGalleryImages.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
