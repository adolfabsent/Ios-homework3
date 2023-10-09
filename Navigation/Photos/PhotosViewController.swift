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
    private var filterArray = [CGImage?]()
    
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
        imageProcessor.processImagesOnThread(sourceImages: Photos.shared.examples, filter: .posterize, qos: .utility ) { self.filterArray = $0
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            DispatchQueue.main.async {
                let endDate = Date.timeIntervalSinceReferenceDate
                print("End time --- \(Date.timeIntervalSinceReferenceDate)")
                print("Result === \(endDate - startDate)")
            }
        }
    }
    
    
    // QOS time:
    //default: === 1.1624889373779297
    //background: === 3.6656999588012695
    //userInitiated: === 0.994513988494873
    //userInteractive: === 0.904850959777832
    //utility: === 1.0119709968566895
    
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
        return filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        var image = UIImage()
        if let cgImage = filterArray[indexPath.row] {
            image = UIImage(cgImage: cgImage)
        } else {
            image = UIImage(systemName: "photo.fill")!
        }
        cell.configCellCollection(photo: image)
        return cell
    }
}

