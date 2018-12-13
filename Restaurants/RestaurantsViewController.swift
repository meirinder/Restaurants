//
//  FirstViewController.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var restaurantViewModel = RestaurantsViewModel()

    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    
    func reloadTableView() {
        restaurantsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantViewModel.itemStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantTableViewCell
        cell.ratingLabel.text = restaurantViewModel.restaurantRating(index: indexPath.row)
        cell.restaurantNameLabel.text = restaurantViewModel.restaurantName(index: indexPath.row)
        cell.specificationLabel.text = restaurantViewModel.restaurantSpecification(index: indexPath.row)
        cell.restaurantImageView.image = restaurantViewModel.restaurantImage(index: indexPath.row)
        return cell
    }
    
    


}


