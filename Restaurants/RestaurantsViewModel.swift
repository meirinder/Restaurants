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
    
    override init() {
        self.restaurantStore = RestaurantStore()
        super.init()
    }
    
    init(restaurantStore: RestaurantStore) {
        self.restaurantStore = restaurantStore
        super.init()
    }
    
    func updateRestaurants(){
        restaurantStore.updateRestaurantStore(){
            self.fillItemStore(restaraunts: self.restaurantStore.restaurants())
            self.delegate?.updateTableView()
            
        }
    }
    
    private func fillItemStore(restaraunts: [Restaurant]) {
        itemStore.removeAll()
        for restaraunt in restaraunts{
            let item = Item(name: restaraunt.name ?? "", specification: restaraunt.description ?? "", photoURL: restaraunt.imagePaths?.first ?? "", rating: restaraunt.rating ?? 0)
            item.setImages()
            itemStore.append(item)
        }
    }
    

    
}
