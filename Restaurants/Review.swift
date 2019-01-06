//
//  Review.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import Foundation

struct Review: Codable{
    let restaurantId: Int?
    let author: String?
    let reviewText: String?
    let date: String?
    
    init(restaurantId: Int, author: String, reviewText: String, date: String) {
        self.reviewText = reviewText
        self.restaurantId = restaurantId
        self.author = author
        self.date = date
    }
}

struct Safe<Base: Decodable>: Decodable {
    public let value: Base?
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
          //  assertionFailure("ERROR: \(error)")
            // TODO: automatically send a report about a corrupted data
            self.value = nil
        }
    }
}
