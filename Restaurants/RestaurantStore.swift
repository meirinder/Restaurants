//
//  RestaurantStore.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantStore: NSObject {
    private var restaurantsList: [String]
    
    override init() {
        restaurantsList = [String]()
    }
    
    init(restaurants: [String]) {
        self.restaurantsList = restaurants
    }
    
    func setRestaurants(restaraunts: [String]) {
        self.restaurantsList = restaraunts
    }
    
    func restaurants() -> [String] {
        return restaurantsList
    }
    
    func updateRestaurants(){
        
    }

}
