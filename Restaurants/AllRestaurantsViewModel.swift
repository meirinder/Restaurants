//
//  AllRestaurantsViewModel.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class AllRestaurantsViewModel: RestaurantsViewModel {
        
    override func fillItemStore(restaraunts: [Restaurant]) {
        for restaraunt in restaraunts{
            let item = Item(name: restaraunt.name ?? "", specification: restaraunt.description ?? "", photoURL: restaraunt.imagePaths?.first ?? "", rating: restaraunt.rating ?? 0)
            item.setImages()
            itemStore.append(item)
        }
    }
    
    override func restaurantName(index: Int) -> String {
        return itemStore[index].name
    }
    override func restaurantImage(index: Int) -> UIImage {
        return itemStore[index].photo
    }
    override func restaurantSpecification(index: Int) -> String {
        return itemStore[index].specification
    }
    override func restaurantRating(index: Int) -> String {
        return "\(itemStore[index].rating)"
    }

}
