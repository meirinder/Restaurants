//
//  FirstViewController.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTableViewDelegate {
    
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.restaurantsTableView.reloadData()
        }
    }
    
    
    var restaurantViewModel = RestaurantsViewModel()

    
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    @IBAction func test(_ sender: Any) {
        restaurantViewModel.updateRestaurantsFromNet()
//        reloadTableView()
    }
    
    func reloadTableView() {
        restaurantsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantViewModel.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantViewModel.itemStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantTableViewCell
        cell.item = restaurantViewModel.itemStore[indexPath.row]
        cell.setItem()
        return cell
    }
    
    


}


protocol UpdateTableViewDelegate: class {
    func updateTableView()
}
