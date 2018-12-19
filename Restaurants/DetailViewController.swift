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
        return detailViewModel.countOfMessages()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as? ReviewTableViewCell
        detailViewModel.tapCell(index: indexPath.row)
//        tableView.reloadData()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewsTableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        cell.authorLabel.text = detailViewModel.authorAt(index: indexPath.row)
        cell.messageLabel.text = detailViewModel.messageAt(index: indexPath.row)
        cell.dateLabel.text = detailViewModel.dateAt(index: indexPath.row)
        
        cell.cellHeightConstraint.constant = CGFloat(detailViewModel.heightOfCell(index: indexPath.row))
        cell.dateLabel.isHidden = detailViewModel.dateIsHidden(index: indexPath.row)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        reviewsTableView.rowHeight = UITableView.automaticDimension
//        reviewsTableView.estimatedRowHeight = 50
 
        
        let restaurantLocation = CLLocationCoordinate2D(latitude: detailViewModel.location().lat!, longitude: detailViewModel.location().lon!)
        
        
        
        //Center the map on the place location
        restaurantLocationMapView.setCenter(restaurantLocation, animated: true)

        let sourceLocation = CLLocationCoordinate2D(latitude: detailViewModel.location().lat!, longitude: detailViewModel.location().lon!)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let sourceAnnotation = MKPointAnnotation()
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        restaurantLocationMapView.showAnnotations([sourceAnnotation], animated: true)
        
        detailViewModel.delegate = self
        prepareForDisplay()
        reviewsTableView.reloadData()
        // Do any additional setup after loading the view.
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
    func updateImage() {
        DispatchQueue.main.async {
            self.restaurantImageView.image = self.detailViewModel.mainImage
            print(self.detailViewModel.mainImage.size.height)
            print(self.detailViewModel.mainImage.size.width)
            self.heightImageViewConstraint.constant = self.detailViewModel.calculateHeightImageViewConstraint(imageHeight: self.detailViewModel.mainImage.size.height, imageWidth: self.detailViewModel.mainImage.size.width, imageViewWidthConstarint: self.restaurantImageView.bounds.width)
            self.view.layoutIfNeeded()
        }
    }
    func updateReviews(){
        DispatchQueue.main.async {
            self.reviewsTableView.reloadData()
        }
    }
}



protocol UpdateDetailViewControllerDelegate: class {
    func updateImage()
    func updateReviews()
}
