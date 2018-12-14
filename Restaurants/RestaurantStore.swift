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
    weak var delegate: UpdateRestaurantsProtocol?
    
    
    override init() {
        self.restaurantsList = []
    }
    
    init(restaurants: [Restaurant], delegate: UpdateRestaurantsProtocol) {
        self.restaurantsList = restaurants
    }
    

    func restaurants() -> [Restaurant] {
        return restaurantsList
    }
    
    func updateRestaurantsFromNet(url: String){
        httpConnector.getRestaurantsDataFrom(url: url){ outData in
            self.restaurantsList = self.jsonParser.parseResaurantsData(data: outData)
            
            self.delegate?.updateData()
        }
    }

}

protocol UpdateRestaurantsProtocol: class{
    func updateData()
}
