//
//  HTTPConnector.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class HTTPConnector: NSObject {

    
    func getRestaurantsDataFrom(url: String,completion: @escaping (Data) -> ()){
        let testURL = URL(string:url)!
        var reqest = URLRequest(url: testURL)
        reqest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
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
    
    func getReviewsDataFrom(url: String,completion: @escaping (Data) -> ()){
        
        let firstPath = url.dropLast(25)
        let lastPath = url.dropFirst(url.count - 25)
        
        let encoded = lastPath.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let testURL = URL(string:firstPath + encoded!)!
        var reqest = URLRequest(url: testURL)
        reqest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
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
    
}
