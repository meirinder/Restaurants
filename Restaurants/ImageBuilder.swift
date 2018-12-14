//
//  ImageBuilder.swift
//  Restaurants
//
//  Created by Savely on 14.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class ImageBuilder: NSObject {

   
    
    func downloadImage(from url: URL,oldImage: UIImage, completion: @escaping (UIImage) -> ()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
           // DispatchQueue.main.async() {
                let test =  UIImage(data: data)!
                if test == oldImage{
                    print("ooooodinakovue")
                    completion(test)
                }
           // }
        }
    }
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
