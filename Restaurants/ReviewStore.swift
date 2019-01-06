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
    
    
    
    
    func reviews() -> [Review] {
        return reviewsList
    }
    
    func updateRewiewsFromNet(id: Int){
        httpConnector.getReviewsDataFrom(id: id){ outData in
            self.reviewsDicitionary = self.jsonParser.parseReviewsData(data: outData)
            self.reviewsList.removeAll()
            for value in self.reviewsDicitionary.values {
                self.reviewsList.append(value)
            }
            self.reviewsList = self.reviewsList.sorted(by: { ($0.date ?? "") < ($1.date ?? "") })
            self.delegate?.updateData()
        }
        
    }
    
}

protocol UpdateReviewsProtocol: class{
    func updateData()
}
