//
//  HTTPConnector.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class HTTPConnector: NSObject {
    private let restaurantLink = "https://restaurants-f64d7.firebaseio.com/restaurants.json"
    private let reviewLink =  "https://restaurants-f64d7.firebaseio.com/reviews.json?orderBy=\"restaurantId\"&equalTo="

    
    func getRestaurantsDataFrom(completion: @escaping (Data) -> ()){
        let testURL = URL(string: restaurantLink)!
        var request = URLRequest(url: testURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
         //   let responseString = String(data: data, encoding: .utf8)
         //   print("responseString = \(String(describing: responseString))")
            completion(data)
        }
        task.resume()
    }
    
    func getReviewsDataFrom(id: Int,completion: @escaping (Data) -> ()){
        
        let link = reviewLink + "\(id)"
        
        let firstPath = link.dropLast(25)
        let lastPath = link.dropFirst(link.count - 25)
        
        let encoded = lastPath.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let testURL = URL(string:firstPath + encoded!)!
        var request = URLRequest(url: testURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
//               let responseString = String(data: data, encoding: .utf8)
//               print("responseString = \(String(describing: responseString))")
            completion(data)
        }
        task.resume()
    }
    
    func postReviewData(data: Data, link: String, completion: @escaping (Bool) -> ()) {
        let testURL = URL(string: link)!
        var request = URLRequest(url: testURL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response ?? nil))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            completion(true)
        }
        task.resume()
    }
    
}
