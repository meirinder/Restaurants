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
    
    override init() {
        reviewsDicitionary = [String:Review]()
    }
    
    init(rewiews: [String:Review]) {
        self.reviewsDicitionary = rewiews
    }
    
    func setRewiews(rewiews: [String:Review]) {
        self.reviewsDicitionary = rewiews
    }
    
    func reviews() -> [String:Review] {
        return reviewsDicitionary
    }
    
    func updateRewiews(){
        
    }
    
}

