//
//  ImageBuilder.swift
//  Restaurants
//
//  Created by Savely on 14.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class ImageBuilder: NSObject {
    
    var imageStore = ImageStore().shared()
    
    func getImageFromNet(url: URL,completion: @escaping (UIImage) -> ()) {
        let imageCheck = imageStore.tryGetImageStatusWithUrl(url: url)
        
        if let imageCheck = imageCheck {
            switch imageCheck {
            case  .loaded(let image):
                completion(image)
                return
            case .loading(var completions):
                completions.append(completion)
                imageStore.updateCompletion(url: url, newCompletions: completions)
                return
            }
        }
        downloadImage(from: url){ outImage in
            completion(outImage)
        }
    }
    

    private func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()) {
        print("Download Started")
        self.imageStore.setPair(url: url, imageStatus: .loading(completions: [completion]))
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            let imageStatus = self.imageStore.tryGetImageStatusWithUrl(url: url)
            
            self.imageStore.updatePair(url: url, image: UIImage(data: data)!)
            
            if let imageStatus = imageStatus {
                switch imageStatus{
                case .loading(let completions):
                    for complet in completions{
                        complet(UIImage(data: data)!)
                    }
                    break
                case .loaded:
                    break
                }
            }
        }
    }
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
