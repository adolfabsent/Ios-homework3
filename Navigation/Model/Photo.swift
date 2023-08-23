//
//  Photo.swift
//  Navigation
//
//  Created by Максим Зиновьев on 23.08.2023.
//

import UIKit

struct PhotoGallery {
    var image: String

    static func setupImage() -> [PhotoGallery] {
        var image = [PhotoGallery]()

        image.append(PhotoGallery(image: "1"))
        image.append(PhotoGallery(image: "2"))
        image.append(PhotoGallery(image: "3"))
        image.append(PhotoGallery(image: "4"))
        image.append(PhotoGallery(image: "5"))
        image.append(PhotoGallery(image: "6"))
        image.append(PhotoGallery(image: "7"))
        image.append(PhotoGallery(image: "8"))
        image.append(PhotoGallery(image: "9"))
        image.append(PhotoGallery(image: "10"))
        image.append(PhotoGallery(image: "11"))
        image.append(PhotoGallery(image: "12"))
        image.append(PhotoGallery(image: "13"))
        image.append(PhotoGallery(image: "14"))
        image.append(PhotoGallery(image: "15"))
        image.append(PhotoGallery(image: "16"))
        image.append(PhotoGallery(image: "17"))
        image.append(PhotoGallery(image: "18"))
        image.append(PhotoGallery(image: "19"))
        image.append(PhotoGallery(image: "20"))

        return image
    }
}
