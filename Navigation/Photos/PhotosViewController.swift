//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Максим Зиновьев on 15.08.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let photoIdent = "photoCell"
    private let imageProcessor = ImageProcessor()
    private var photos = Photos.shared.examples

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photos.translatesAutoresizingMaskIntoConstraints = false
        photos.backgroundColor = .white
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photoIdent)
        return photos
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery"
        self.view.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        setupConstraints()


        let startDate = Date.timeIntervalSinceReferenceDate
                print("Start time --- \(Date.timeIntervalSinceReferenceDate)")
                imageProcessor.processImagesOnThread(sourceImages: Photos.shared.examples, filter: .posterize, qos: .default ) { [weak self] cgImages in
                    var result = [UIImage]()
                    for cgImage in cgImages {
                        guard let cgImage = cgImage else {
                            continue
                        }
                        result.append(UIImage(cgImage: cgImage))
                    }
                    self?.photos = result
                    DispatchQueue.main.async {
                        let endDate = Date.timeIntervalSinceReferenceDate
                        print("End time --- \(Date.timeIntervalSinceReferenceDate)")
                        print("Result === \(endDate - startDate)")
                        self?.collectionView.reloadData()
                    }
                }
    }


// QOS time:
//default: === 1.3786860704421997
//background: === 3.9672091007232666
//userInitiated: === 0.8964539766311646
//userInteractive: === 0.8805649280548096
//utility: Result === 3.3349239826202393

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

    }


}


extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItem: CGFloat = 2
        let accessibleWidth = collectionView.frame.width - 32
        let widthItem = (accessibleWidth / countItem)
        return CGSize(width: widthItem, height: widthItem * 0.56)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Photos.shared.examples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.configCellCollection(photo: Photos.shared.examples[indexPath.item])
        return cell
    }
}

