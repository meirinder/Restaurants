//
//  FirstViewController.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTableViewDelegate {
   
    func stopRefreshing() {
        let deadline = DispatchTime.now() + .milliseconds(700)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refresher.endRefreshing()
        }
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    @objc
    func refreshData(){
        restaurantViewModel.updateRestaurants()
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.reloadTableView()
        }
    }
    
    
    var restaurantViewModel = RestaurantsViewModel()

    @IBOutlet weak var restaurantsTableView: UITableView!
    
    func reloadTableView() {
        restaurantsTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restaurantViewModel.updateRestaurants()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantViewModel.delegate = self
        restaurantViewModel.updateRestaurants()
        
        
        restaurantsTableView.refreshControl = refresher
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantViewModel.resturantsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantTableViewCell
        cell.item = restaurantViewModel.itemStore[indexPath.row]
        cell.setItem()
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRestaurantDetailSegue" {
            if let indexPath = self.restaurantsTableView.indexPathForSelectedRow {
                let restaurantAtIndexPath = restaurantViewModel.restaurantStore.restaurants()[indexPath.row]
                let localRestaurantStore = RestaurantStore(restaurants: [restaurantAtIndexPath])
                let localDetailViewModel = DetailViewModel(restaurantStore: localRestaurantStore)
               
                let destinationVC = segue.destination as! DetailViewController
                
                destinationVC.detailViewModel = localDetailViewModel
            }
        }
    }

}


protocol UpdateTableViewDelegate: class {
    func updateTableView()
    func stopRefreshing()
}
