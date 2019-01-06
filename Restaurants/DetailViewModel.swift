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
    private var isInstallableCell: [Bool] = []
    private let imageLoader = ImageLoader().shared()
    private let defaults = UserDefaults.standard

    weak var delegate: UpdateDetailViewControllerDelegate?
    var mainImage = UIImage()
    private var otherImages: [UIImage] = []

    func setFavourite(){
        if isFavouriteResturant() {
            var ids = defaults.array(forKey: "FavouriteRestaurantId")  as? [Int] ?? [Int]()
            for i in 0..<ids.count {
                if ids[i] == resaurantId() {
                    ids.remove(at: i)
                    defaults.set(ids, forKey: "FavouriteRestaurantId")
                    return
                }
            }
            print("Restaurant not found")
        
        }else {
            var ids = defaults.array(forKey: "FavouriteRestaurantId")  as? [Int] ?? [Int]()
            ids.append(resaurantId())
            defaults.set(ids, forKey: "FavouriteRestaurantId")
        }
    }
    
    
    
    func isFavouriteResturant() -> Bool {
        let ids = defaults.array(forKey: "FavouriteRestaurantId")  as? [Int] ?? [Int]()
        for id in ids {
            if id == resaurantId(){
                return true
            }
        }
        return false
    }
    
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
        if let images = restaurantStore.restaurants().first?.imagePaths {
            for _ in images  {
                self.otherImages.append(UIImage())
                self.isInstallableCell.append(false)
            }
        }
    }
    
    func restaurantImagesCount() -> Int {
        return (restaurantStore.restaurants().first?.imagePaths?.count)!
    }
    
    init(restaurantStore: RestaurantStore, reviewStore: ReviewStore = ReviewStore()) {
        self.restaurantStore = restaurantStore
        self.reviewStore = reviewStore
        super.init()
        self.reviewStore.delegate = self
        if let images = restaurantStore.restaurants().first?.imagePaths {
            for _ in images  {
                self.otherImages.append(UIImage())
                self.isInstallableCell.append(false)
            }
        }
    }
    
    func imagesForCollectionView() -> [UIImage]{
        return otherImages
    }
    
    func reviews(id: Int) {
        reviewStore.updateRewiewsFromNet(id: id)
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
    
    func resaurantId() -> Int {
        return (restaurantStore.restaurants().first?.id)!
    }
    
    func loadMainImage(){
        if let url = URL(string: ((restaurantStore.restaurants().first?.imagePaths?.first)!)) {
            imageLoader.getImageFromNet(url: url){ outImage in
                self.mainImage = outImage
                self.delegate?.updateMainImage()
            }
        }
    }
    
    func isInstallableImage(index: Int) -> Bool {
        return isInstallableCell[index]
    }

    func loadAllImages(){
        let images = (self.restaurantStore.restaurants().first?.imagePaths)!
        for link in images {
            if let url = URL(string: link) {
                var item = 0
                imageLoader.getImageFromNet(url: url){ outImage in
                    for image in self.otherImages{
                        if image == outImage {
                            return
                        }
                    }
                    for i in 0..<images.count{
                        if images[i] == link {
                            self.otherImages[i] = outImage
                            self.isInstallableCell[i] = true
                            item = i
                        }
                    }
                    self.delegate?.updateOtherImages(item: item)
                }
            }
        }
        
    }
    
    
}
