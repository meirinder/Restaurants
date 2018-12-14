//
//  ReviewStore.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class ReviewStore: NSObject {
    
    
    private var reviewsDicitionary: [String:Review]
    private let httpConnector = HTTPConnector()
    private let jsonParser = JSONParser()
    
    override init() {
        reviewsDicitionary = [String:Review]()
    }
    
    
    func setRewiews( ) {
    
    }
    
    func reviews() -> [String:Review] {
        return reviewsDicitionary
    }
    
    func updateRewiewsFromNet(url: String){
        
    }
    
}

