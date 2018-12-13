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
            downloadImage(from: url)
        }
    }
    
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.photo = UIImage(data: data)!
            }
        }
    }
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
