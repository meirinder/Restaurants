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

    let restaurants: [Restaurant]
    var annotations: [MKAnnotation] = []
    
    override init() {
        restaurants = [Restaurant]()
    }
    
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    func buildAnnotations() -> [MKAnnotation] {
        for restaurant in restaurants {
            let sourceLocation = CLLocationCoordinate2D(latitude: (restaurant.location?.lat)!, longitude: (restaurant.location?.lon)!)
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let sourceAnnotation = MKPointAnnotation()
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            annotations.append(sourceAnnotation)
        }
        
        return annotations
    }
    
}
