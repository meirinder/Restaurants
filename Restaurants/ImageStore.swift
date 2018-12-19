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

class ImageStore: NSObject {
    
    
 
    
    private static let sharedInstanse = ImageStore()
    
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
    
    
    func shared() -> ImageStore {
        return ImageStore.sharedInstanse
    }
    
}

