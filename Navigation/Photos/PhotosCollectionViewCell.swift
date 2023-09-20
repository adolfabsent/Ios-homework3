//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Максим Зиновьев on 15.08.2023.
//

import UIKit
import  iOSIntPackage

class PhotosCollectionViewCell: UICollectionViewCell {

    var photoImageView: UIImageView = {
         let photos = UIImageView()
         photos.contentMode = .scaleAspectFill
         photos.layer.cornerRadius = 6
         photos.clipsToBounds = true
         photos.translatesAutoresizingMaskIntoConstraints = false
         return photos
     }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configCellCollection(photo: UIImage) {
           self.photoImageView.image = photo
       }
}




