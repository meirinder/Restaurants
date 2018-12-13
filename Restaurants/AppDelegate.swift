//
//  AppDelegate.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var restaurants = [Restaurant]()
        var reviews = [String:Review]()
        HTTPConnector.getRestaurantsDataFrom(url:"https://restaurants-f64d7.firebaseio.com/restaurants.json"){outData in
            restaurants = JSONParser.parseResaurantsData(data: outData)
            
            DispatchQueue.main.async {
                self.configureControllers(restaurants: restaurants)
            }
            
        }
        HTTPConnector.getReviewsDataFrom(url: "https://restaurants-f64d7.firebaseio.com/reviews.json"){ outData in
            reviews = JSONParser.parseReviewsData(data: outData)
            
        }
        
        
        // Override point for customization after application launch.
        return true
    }

    func configureControllers(restaurants:[Restaurant]){
        if (self.window?.rootViewController?.isKind(of: UITabBarController.self)) ?? false {
            let tabBarController = self.window?.rootViewController as! UITabBarController
            if (tabBarController.viewControllers?.first?.isKind(of: UINavigationController.self)) ?? false {
                сonfigureAllRestaurantsViewController(tabBarController: tabBarController, restaurants: restaurants)
                configureFavouriteViewConroller(tabBarController: tabBarController, restaurants: restaurants)
            }
            if (tabBarController.viewControllers?[2].isKind(of: MapViewController.self) ?? false){
                configureMapViewController(tabBarController: tabBarController, restaurants: restaurants)
                
            }
        }
    }
    
    func configureMapViewController(tabBarController: UITabBarController,restaurants:[Restaurant]) {
        let mapViewController = tabBarController.viewControllers?[2] as! MapViewController
        mapViewController.loadView()
        let mapViewModel = MapViewModel(restaurants: restaurants)
        mapViewController.mapViewModel = mapViewModel
        mapViewController.test()
    }
    
    func configureFavouriteViewConroller(tabBarController: UITabBarController,restaurants:[Restaurant]) {
        let favouriteRestaurantsViewModel = FavouriteRestaurantsViewModel()
        
        let favRestaurants:[Restaurant] = [restaurants[0],restaurants[1]]
        favouriteRestaurantsViewModel.fillItemStore(restaraunts: favRestaurants)
        
        
        let favouriteRestaurantsNavigationController = tabBarController.viewControllers?[1] as! UINavigationController
        if ((favouriteRestaurantsNavigationController.viewControllers.first?.isKind(of: RestaurantsViewController.self))! ){
            let favouriteRestaurantsViewController = favouriteRestaurantsNavigationController.viewControllers.first as! RestaurantsViewController
            favouriteRestaurantsViewController.loadView()
            favouriteRestaurantsViewController.restaurantViewModel = favouriteRestaurantsViewModel
            favouriteRestaurantsViewController.reloadTableView()
        }
    }
    
    func сonfigureAllRestaurantsViewController(tabBarController: UITabBarController,restaurants:[Restaurant]) {
        let allRestaurantsViewModel = AllRestaurantsViewModel()
        allRestaurantsViewModel.fillItemStore(restaraunts: restaurants)
        let restaurantsNavigationController = tabBarController.viewControllers?.first as! UINavigationController
        if (restaurantsNavigationController.viewControllers.first?.isKind(of: RestaurantsViewController.self) ?? false){
            let restaurantsViewController = restaurantsNavigationController.viewControllers.first as! RestaurantsViewController
            restaurantsViewController.restaurantViewModel = allRestaurantsViewModel
            restaurantsViewController.reloadTableView()
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
