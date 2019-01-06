//
//  MapViewModel.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit
import MapKit

class MapViewModel: NSObject {

    let restaurantStore: RestaurantStore
    var annotations: [MKAnnotation] = []
    var currentTitle: String = ""
    
    override init() {
        restaurantStore = RestaurantStore()
    }
    
    init(restaurantStore: RestaurantStore) {
        self.restaurantStore = restaurantStore
    }
    
    
    func searchIndex() -> Int{
        for i in 0..<restaurantStore.restaurants().count {
            if restaurantStore.restaurants()[i].name == currentTitle{
                return i
            }
        }
        return 0
    }
    
    func buildAnnotations() -> [MKAnnotation] {
        if restaurantStore.restaurants().first?.id == nil {
            return annotations
        }
        for restaurant in restaurantStore.restaurants() {
            let sourceLocation = CLLocationCoordinate2D(latitude: (restaurant.location?.lat)!, longitude: (restaurant.location?.lon)!)
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let sourceAnnotation = MKPointAnnotation()
            
            sourceAnnotation.title = restaurant.name
            
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            annotations.append(sourceAnnotation)
        }
        
        return annotations
    }
    
}
