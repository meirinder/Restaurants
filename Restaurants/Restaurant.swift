//
//  Restaurant.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let address: String?
    let location: Location?
    let imagePaths: [String]?
    let rating: Float?
    init() {
        id = nil
        name = nil
        description = nil
        address = nil
        location = nil
        imagePaths = nil
        rating = nil
    }
    init(id: Int, name: String, description: String, address: String, lonLocation: Double, latLocation: Double, imagePath: String, rating: Float) {
        self.id = id
        self.name = name
        self.description = description
        self.address = address
        self.imagePaths = []
        self.imagePaths?.append(imagePath)
        self.rating = rating
        self.location = Location(lat: latLocation, lon: lonLocation)
    }
}

struct Location: Decodable {
    let lat: Double?
    let lon: Double?
    init(lat: Double, lon: Double) {
        self.lon = lon
        self.lat = lat
    }
}
