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
    
}

struct Location: Decodable {
    let lat: Double?
    let lon: Double?
}
