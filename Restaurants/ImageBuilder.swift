//
//  ImageBuilder.swift
//  Restaurants
//
//  Created by Savely on 14.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class ImageBuilder: NSObject {

    func getImageFromNet(url: URL,completion: @escaping (UIImage) -> ()) {
        downloadImage(from: url){ outImage in
            completion(outImage)
        }
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            completion(UIImage(data: data)!)
//            DispatchQueue.main.async() {
//                self.photo = UIImage(data: data)!
//            }
        }
    }
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
