//
//  AddReviewViewModel.swift
//  Restaurants
//
//  Created by Savely on 19.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class AddReviewViewModel: NSObject {

    private let restaurantId: Int
    
    init(restaurantId: Int) {
        self.restaurantId = restaurantId
    }
    
    override init() {
        self.restaurantId = 0
    }
    
    func sendReview(text: String, author: String, completion: @escaping (Bool) -> ()){
        let jsonParser = JSONParser()
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxx"
        let reviewDate = formatter.string(from: currentDate)
        let review = Review(restaurantId: restaurantId, author: author, reviewText: text, date: reviewDate)
        if let data = jsonParser.synthesizeReviewsData(review: review) {
            let httpCon = HTTPConnector()
            httpCon.postReviewData(data: data, link: "https://restaurants-f64d7.firebaseio.com/reviews.json"){ success in
                completion(success)
            }
        }

    }
    
}
