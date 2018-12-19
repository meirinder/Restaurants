//
//  DetailViewModel.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class DetailViewModel: NSObject, UpdateReviewsProtocol {

    private var restaurantStore: RestaurantStore
    private var reviewStore: ReviewStore
    private var isTappedCell: [Bool] = []
    weak var delegate: UpdateDetailViewControllerDelegate?
    var mainImage = UIImage()
    
    func updateData() {
        for _ in reviewStore.reviews() {
            isTappedCell.append(false)
        }
        delegate?.updateReviews()
    }
    
    override init() {
        self.restaurantStore = RestaurantStore()
        self.reviewStore = ReviewStore()
        super.init()
        self.reviewStore.delegate = self
    }
    
    init(restaurantStroe: RestaurantStore, reviewStore: ReviewStore = ReviewStore()) {
        self.restaurantStore = restaurantStroe
        self.reviewStore = reviewStore
        super.init()
        self.reviewStore.delegate = self
    }
    
    func reviews(id: Int) {
        reviewStore.updateRewiewsFromNet(url:"https://restaurants-75cfb.firebaseio.com/reviews.json?orderBy=\"restaurantId\"&equalTo=\(id)" )
    }
    
    func heightOfCell(index: Int) -> Int {
        if isTappedCell[index]{
            return 200
        }
        return 68
    }
    
    func calculateHeightImageViewConstraint(imageHeight: CGFloat, imageWidth: CGFloat, imageViewWidthConstarint: CGFloat) -> CGFloat {
        if (imageWidth > 0) {
            let res = imageHeight*(imageViewWidthConstarint/imageWidth)
            return res
        } else {
            return 0
        }
    }
    
    func tapCell(index: Int){
        isTappedCell[index] = !isTappedCell[index]
    }
    
    func authorAt(index: Int) -> String {
        return reviewStore.reviews()[index].author ?? ""
    }
    
    func messageAt(index: Int) -> String {
        return "Description: " + (reviewStore.reviews()[index].reviewText ?? "")
    }

    func dateAt(index: Int) -> String {
        return "Date: " + (reviewStore.reviews()[index].date ?? "")
    }
    
    func dateIsHidden(index: Int) -> Bool {
        return !isTappedCell[index]
    }
    
    func itCellIsAdd(index: Int) -> Bool {
        if index == reviewStore.reviews().count {
            return true
        }
        return false
    }
    
    func countOfMessages() -> Int{
        return reviewStore.reviews().count
    }
    
    func restaurantSpecification() -> String {
        return restaurantStore.restaurants().first?.description ?? ""
    }
    
    func restaurantName() -> String {
        return restaurantStore.restaurants().first?.name ?? ""
    }
    
    func restaurantAddress() -> String {
        return restaurantStore.restaurants().first?.address ?? ""
    }
    
    func restaurantId() -> Int {
        return restaurantStore.restaurants().first?.id ?? 0 
    }
    
    func location() -> Location {
        return (restaurantStore.restaurants().first?.location)!
    }
    
    func loadMainImage(){
        let imageBuilder = ImageBuilder()
        if let url = URL(string: ((restaurantStore.restaurants().first?.imagePaths?.first)!)) {
            imageBuilder.getImageFromNet(url: url){ outImage in
                self.mainImage = outImage
                self.delegate?.updateImage()
            }
        }
    }
    
    
}
