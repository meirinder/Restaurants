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
    private var reviewsList: [Review] = []
    
    weak var delegate: UpdateReviewsProtocol?
    
    override init() {
        reviewsDicitionary = [String:Review]()
    }
    
    
    func setRewiews( ) {
    
    }
    
    func reviews() -> [Review] {
        return reviewsList
    }
    
    func updateRewiewsFromNet(url: String){
        httpConnector.getReviewsDataFrom(url: url){ outData in
            self.reviewsDicitionary = self.jsonParser.parseReviewsData(data: outData)
            for value in self.reviewsDicitionary.values {
                self.reviewsList.append(value)
            }
            self.delegate?.updateData()
        }
        
    }
    
}

protocol UpdateReviewsProtocol: class{
    func updateData()
}
