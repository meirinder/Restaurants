//
//  DataBaseWorker.swift
//  Restaurants
//
//  Created by Savely on 06/01/2019.
//  Copyright © 2019 Kulizhnikov. All rights reserved.
//

import UIKit
import RealmSwift

class DataBaseWorker: NSObject {

    private var realm = try? Realm()
    
    func saveCurrentRestaurants(restaurants: [Restaurant]) {
        try? realm?.write {
            realm?.deleteAll()
        }
        let restaurantRealmModel = convertModelToDataBaseModel(restaurants: restaurants)
        try? realm?.write {
            realm?.add(restaurantRealmModel)
        }
    }
    
    func loadRestaurants() -> [Restaurant] {
        var resultRestaurants: Results<RestaurantsRealmModel>!
        try? realm?.write {
            resultRestaurants = realm?.objects(RestaurantsRealmModel.self)
        }
        return convertDataBaseModelToModel(resultRestaurants: resultRestaurants)
    }
    
    private func convertDataBaseModelToModel(resultRestaurants: Results<RestaurantsRealmModel>) -> [Restaurant] {
        var restaurants = [Restaurant]()
        for restaurantDB in resultRestaurants {
            let restaurant = Restaurant(id: restaurantDB.id,
                                        name: restaurantDB.name,
                                        description: restaurantDB.specification,
                                        address: restaurantDB.address,
                                        lonLocation: restaurantDB.lonLocation,
                                        latLocation: restaurantDB.latLocation,
                                        imagePath: restaurantDB.imagePath,
                                        rating: restaurantDB.rating)
            restaurants.append(restaurant)
        }
        return restaurants
    }
    
    private func convertModelToDataBaseModel(restaurants: [Restaurant]) -> [RestaurantsRealmModel] {
        var restaurantsRealmModel = [RestaurantsRealmModel]()
        for restaurant in restaurants{
            let restaurantDB = RestaurantsRealmModel()
            restaurantDB.id = restaurant.id ?? 0
            restaurantDB.address = restaurant.address ?? ""
            restaurantDB.name = restaurant.name ?? ""
            restaurantDB.specification = restaurant.description ?? ""
            restaurantDB.latLocation = restaurant.location?.lat ?? 0
            restaurantDB.lonLocation = restaurant.location?.lon ?? 0
            restaurantDB.rating = restaurant.rating ?? 0
            restaurantDB.imagePath = restaurant.imagePaths?.first ?? ""
            restaurantsRealmModel.append(restaurantDB)
        }
        return restaurantsRealmModel
    }
    
}



class RestaurantsRealmModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var specification = ""
    @objc dynamic var address = ""
    @objc dynamic var latLocation: Double = 0
    @objc dynamic var lonLocation: Double = 0
    @objc dynamic var imagePath = ""
    @objc dynamic var rating: Float = 0
}
