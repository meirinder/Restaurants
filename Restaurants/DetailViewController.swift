//
//  DetailViewController.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    
    
    @IBOutlet weak var heightImageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantImagesCollectionView: UICollectionView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var restaurantLocationMapView: MKMapView!
    
    
    var detailViewModel = DetailViewModel()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.countOfMessages() + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if detailViewModel.itCellIsAdd(index: indexPath.row){
       
            return
        }
        detailViewModel.tapCell(index: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if detailViewModel.itCellIsAdd(index: indexPath.row){
            let cell = reviewsTableView.dequeueReusableCell(withIdentifier: "AddReviewCell")
            return cell!
        }
        let cell = reviewsTableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        cell.authorLabel.text = detailViewModel.authorAt(index: indexPath.row)
        cell.messageLabel.text = detailViewModel.messageAt(index: indexPath.row)
        cell.dateLabel.text = detailViewModel.dateAt(index: indexPath.row)
        
        cell.cellHeightConstraint.constant = CGFloat(detailViewModel.heightOfCell(index: indexPath.row))
        cell.dateLabel.isHidden = detailViewModel.dateIsHidden(index: indexPath.row)
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForDisplay()

        reviewsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let restaurantLocation = CLLocationCoordinate2D(latitude: detailViewModel.location().lat!, longitude: detailViewModel.location().lon!)
        restaurantLocationMapView.setCenter(restaurantLocation, animated: true)

        let sourceLocation = CLLocationCoordinate2D(latitude: detailViewModel.location().lat!, longitude: detailViewModel.location().lon!)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let sourceAnnotation = MKPointAnnotation()
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        restaurantLocationMapView.showAnnotations([sourceAnnotation], animated: true)
        
        detailViewModel.loadAllImages()

        detailViewModel.delegate = self
        
    }
   
   
    func prepareForDisplay(){
        detailViewModel.loadMainImage()
        descriptionLabel.text = detailViewModel.restaurantSpecification()
        restaurantNameLabel.text = detailViewModel.restaurantName()
        restaurantNameLabel.sizeToFit()
        addressLabel.text = detailViewModel.restaurantAddress()
        addressLabel.sizeToFit()
        detailViewModel.reviews(id: detailViewModel.restaurantId())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }
    
    func sizeHeaderToFit() {
        let headerView = reviewsTableView.tableHeaderView!
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        reviewsTableView.tableHeaderView = headerView
    }

}


extension DetailViewController: UpdateDetailViewControllerDelegate{
    func updateOtherImages(item: Int) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: item, section: 0)
            self.restaurantImagesCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    func updateMainImage() {
        DispatchQueue.main.async {
            self.restaurantImageView.image = self.detailViewModel.mainImage
            self.heightImageViewConstraint.constant = self.detailViewModel.calculateHeightImageViewConstraint(imageHeight: self.detailViewModel.mainImage.size.height, imageWidth: self.detailViewModel.mainImage.size.width, imageViewWidthConstarint: self.restaurantImageView.bounds.width)
            self.view.layoutIfNeeded()
        }
    }
    func updateReviews(){
        DispatchQueue.main.async {
            self.reviewsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReviewSegue" {
            let localAddReviewViewModel = AddReviewViewModel(restaurantId: detailViewModel.resaurantId())
            let destinationVC = segue.destination as! AddReviewViewController
            destinationVC.addReviewViewModel = localAddReviewViewModel
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailViewModel.restaurantImagesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = restaurantImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.backgroundImageView.image = detailViewModel.imagesForCollectionView()[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if detailViewModel.isInstallableImage(index: indexPath.row){
            detailViewModel.mainImage = detailViewModel.imagesForCollectionView()[indexPath.row]
            self.updateMainImage()
        }
    }
    
}

protocol UpdateDetailViewControllerDelegate: class {
    func updateMainImage()
    func updateOtherImages(item: Int)
    func updateReviews()
}
