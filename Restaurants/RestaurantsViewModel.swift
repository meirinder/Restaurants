//
//  RestaurantsViewModel.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantsViewModel: NSObject,UpdateRestaurantsProtocol {
    func updateData() {
        fillItemStore(restaraunts: restaurantStore.restaurants())
        delegate?.updateTableView()
    }
    
    var itemStore: [Item] = []
    var restaurantStore: RestaurantStore
    
    weak var delegate: UpdateTableViewDelegate?
    
    override init() {
        self.restaurantStore = RestaurantStore()
        super.init()
        self.restaurantStore.delegate = self
    }
    
    init(restaurantStore: RestaurantStore) {
        self.restaurantStore = restaurantStore
        super.init()
        self.restaurantStore.delegate = self
    }
    
    func updateRestaurantsFromNet(){
        restaurantStore.updateRestaurantsFromNet(url: "https://restaurants-f64d7.firebaseio.com/restaurants.json")
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
