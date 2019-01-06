//
//  FavouriteRestaurantsViewModel.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class FavouriteRestaurantsViewModel: RestaurantsViewModel {
    
    override func fillItemStore(restaraunts: [Restaurant]) {
        itemStore.removeAll()
        for restaraunt in restaraunts{
            if isFavourite(id: restaraunt.id ?? -1){
                let item = Item(name: restaraunt.name ?? "", specification: restaraunt.description ?? "", photoURL: restaraunt.imagePaths?.first ?? "", rating: restaraunt.rating ?? 0)
                item.setImages()
                itemStore.append(item)
            }
        }
    }
    private func isFavourite(id: Int) -> Bool {
        let favouriteIds = defaults.array(forKey: "FavouriteRestaurantId")  as? [Int] ?? [Int]()
        for favouriteId in favouriteIds {
            if favouriteId == id{
                return true
            }
        }
        return false
    }
    
}
