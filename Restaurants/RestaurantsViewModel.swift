//
//  RestaurantsViewModel.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantsViewModel: NSObject {
    
    
    var itemStore: [Item] = []
    var restaurantStore: RestaurantStore
    
    weak var delegate: UpdateTableViewDelegate?
    private var favouriteRestaurantsId = [Int]()
    let defaults = UserDefaults.standard
    
    override init() {
        self.restaurantStore = RestaurantStore()
        super.init()
    }
    
    init(restaurantStore: RestaurantStore) {
        self.restaurantStore = restaurantStore
    }
    
    func resturantsCount() -> Int {
        return itemStore.count
    }
    
    func updateRestaurants(){
        restaurantStore.updateRestaurantStore(){ userData in
            self.fillItemStore(restaraunts: self.restaurantStore.restaurants())
            if userData {
                self.delegate?.stopRefreshing()
            }
            self.delegate?.updateTableView()
            
        }
    }
    
    func fillItemStore(restaraunts: [Restaurant]) {
        itemStore.removeAll()
        for restaraunt in restaraunts{
            let item = Item(name: restaraunt.name ?? "", specification: restaraunt.description ?? "", photoURL: restaraunt.imagePaths?.first ?? "", rating: restaraunt.rating ?? 0)
            item.setImages()
            itemStore.append(item)
        }
    }
    

    
}
