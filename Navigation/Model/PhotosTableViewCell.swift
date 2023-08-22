//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Максим Зиновьев on 15.08.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

private enum Constants {
        static let itemCount: CGFloat = 4
    }

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8

        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .black
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var arrowImageView: UIImageView = {
        let arrow = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
        imageView.image = arrow
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let collectionViewWidth = (UIScreen.main.bounds.width - 48) / Constants.itemCount

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(backView)
        backView.addSubview(collectionLabel)
        backView.addSubview(arrowImageView)
        backView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12.0),
            collectionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12.0),
            arrowImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12.0),
            arrowImageView.centerYAnchor.constraint(equalTo: collectionLabel.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalTo: collectionLabel.heightAnchor),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor, multiplier: 1.0),
            collectionView.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -12.0),
            collectionView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12.0),
            collectionView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12.0),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewWidth)
        ])
    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 3 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        }
        cell.backgroundColor = .systemGray6
        cell.photoGalleryImages.image = UIImage(named: String(indexPath.row + 1) + ".jpeg")
        cell.photoGalleryImages.contentMode = .scaleAspectFill
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}
