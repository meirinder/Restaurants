//
//  RestaurantTableViewCell.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell, UpdateImageProtocol {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var specificationLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    weak var delegate: UpdateTableViewDelegate?
    
    func update(){
        restaurantImageView.image = item.photo
        delegate?.updateTableView()
    }
    
    var item = Item()
    
    func setItem(){
        restaurantImageView.image = item.photo
        restaurantNameLabel.text = item.name
        specificationLabel.text = item.specification
        ratingLabel.text = "\(item.rating)"
        item.delegate = self
        item.setImages()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol UpdateImageProtocol: class {
    func update()
}
