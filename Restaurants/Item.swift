//
//  Item.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var name: String
    var specification: String
    var photo = UIImage()
    var photoURL: String
    var rating: Float
    var loaded = false
    
    
    weak var delegate: UpdateImageProtocol?
    override init() {
        self.name = ""
        self.specification = ""
        self.rating = 0
        self.photoURL = ""
    }
    
    init(name: String, specification: String, photoURL: String, rating: Float) {
        self.name = name
        self.specification = specification
        self.rating = rating
        self.photoURL = photoURL
    }
    
    
    func setImages() {
        if let url = URL(string: photoURL){
            if !loaded{
                loaded = true
                let test = ImageBuilder()
                test.getImageFromNet(url: url){ outImage in
                    DispatchQueue.main.async() {
                        self.photo = outImage
                        self.delegate?.update()
                    }
                }
            }
        }
    }

}
