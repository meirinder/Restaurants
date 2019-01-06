//
//  RestaurantStore.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantStore: NSObject {
    private var restaurantsList: [Restaurant]
    private let httpConnector = HTTPConnector()
    private let jsonParser = JSONParser()
    
    override init() {
        self.restaurantsList = []
    }
    
    init(restaurants: [Restaurant]) {
        self.restaurantsList = restaurants
    }
    

    func restaurants() -> [Restaurant] {
        return restaurantsList
    }
    
    func updateRestaurantStore(completion: @escaping (Bool) -> ()){
        let dbw = DataBaseWorker()
        self.restaurantsList = dbw.loadRestaurants()
        completion(false)
        
        httpConnector.getRestaurantsData(){ outData in
            self.restaurantsList = self.jsonParser.parseResaurantsData(data: outData)
            DispatchQueue.main.async {
                dbw.saveCurrentRestaurants(restaurants: self.restaurantsList)
                completion(true)
            }
        }
    }

}
