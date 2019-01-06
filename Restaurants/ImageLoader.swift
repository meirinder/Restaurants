//
//  ImageStore.swift
//  Restaurants
//
//  Created by Savely on 18.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

enum ImageStatus{
    case loaded(image: UIImage)
    case loading(completions: [(UIImage) -> ()])
}

class ImageLoader: NSObject {
    
    private static let sharedInstanse = ImageLoader()
    
    private var imageDictionary: [URL: ImageStatus?]
    
    override init() {
        imageDictionary = [:]
    }
    
    func setPair(url:URL, imageStatus: ImageStatus) {
            imageDictionary[url] = imageStatus
    }
    
    func updatePair(url: URL, image: UIImage) {
        imageDictionary.updateValue(ImageStatus.loaded(image: image), forKey: url)
    }
    
    func updateCompletion(url: URL, newCompletions: [(UIImage) -> ()]){
        imageDictionary.updateValue(ImageStatus.loading(completions: newCompletions), forKey: url)
    }
    
    func tryGetImageStatusWithUrl(url: URL) -> (ImageStatus?) {
        if let image = imageDictionary[url] {
             return image
        }
        return (nil)
    }
    
    func shared() -> ImageLoader {
        return ImageLoader.sharedInstanse
    }
    
    func getImageFromNet(url: URL,completion: @escaping (UIImage) -> ()) {
        let imageCheck = self.tryGetImageStatusWithUrl(url: url)
        
        if let imageCheck = imageCheck {
            switch imageCheck {
            case  .loaded(let image):
                completion(image)
                return
            case .loading(var completions):
                completions.append(completion)
                self.updateCompletion(url: url, newCompletions: completions)
                return
            }
        }
        downloadImage(from: url){ outImage in
            completion(outImage)
        }
    }
    
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()) {
        print("Download Started")
        self.setPair(url: url, imageStatus: .loading(completions: [completion]))
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            let imageStatus = self.tryGetImageStatusWithUrl(url: url)
            
            self.updatePair(url: url, image: UIImage(data: data)!)
            
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

