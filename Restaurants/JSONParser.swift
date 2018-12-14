//
//  JSONParser.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class JSONParser: NSObject {

    func parseResaurantsData(data: Data) -> [Restaurant] {
        var restaurants = [Restaurant]()
        do{
            restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
        }catch let error {
            print(error)
        }
        return restaurants
    }
    
    func parseReviewsData(data: Data) -> [String:Review] {
        var safeReviews = [String:Safe<Review>]()
        var reviews = [String:Review]()
        do{
            safeReviews = try JSONDecoder().decode([String:Safe<Review>].self, from: data)
        }catch let error {
            print(error)
        }
        for safeReview in safeReviews{
            if safeReview.value.value == nil{
                safeReviews.removeValue(forKey: safeReview.key)
            }
        }
        for safeReview in safeReviews{
            reviews[safeReview.key] = safeReview.value.value
        }
        return reviews
    }
    
}
