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

        
        
        
        
        configureControllers(restaurantStore: RestaurantStore())
        
        // Override point for customization after application launch.
        return true
    }

    func configureControllers(restaurantStore:RestaurantStore){
        if (self.window?.rootViewController?.isKind(of: UITabBarController.self)) ?? false {
            let tabBarController = self.window?.rootViewController as! UITabBarController
            if (tabBarController.viewControllers?.first?.isKind(of: UINavigationController.self)) ?? false {
                сonfigureAllRestaurantsViewController(tabBarController: tabBarController, restaurantStore: restaurantStore)
                configureFavouriteViewConroller(tabBarController: tabBarController, restaurantStore: restaurantStore)
                configureMapViewController(tabBarController: tabBarController, restaurantStore: restaurantStore)
            }
        }
    }
    
    func configureMapViewController(tabBarController: UITabBarController,restaurantStore: RestaurantStore) {
        if (tabBarController.viewControllers?[2].isKind(of: UINavigationController.self) ?? false){
            let mapNavigationController = tabBarController.viewControllers?[2] as! UINavigationController
            let mapViewModel = MapViewModel(restaurantStore: restaurantStore)
            if (mapNavigationController.viewControllers.first?.isKind(of: MapViewController.self) ?? false){
                let mapViewController = mapNavigationController.viewControllers.first as! MapViewController
                mapViewController.mapViewModel = mapViewModel
            }
        }
    }
    
    func configureFavouriteViewConroller(tabBarController: UITabBarController,restaurantStore: RestaurantStore) {
        let favouriteRestaurantsViewModel = FavouriteRestaurantsViewModel(restaurantStore: restaurantStore)
        if (tabBarController.viewControllers?[1].isKind(of: UINavigationController.self) ?? false){
            let favouriteRestaurantsNavigationController = tabBarController.viewControllers?[1] as! UINavigationController
            if ((favouriteRestaurantsNavigationController.viewControllers.first?.isKind(of: RestaurantsViewController.self)) ?? false){
                let favouriteRestaurantsViewController = favouriteRestaurantsNavigationController.viewControllers.first as! RestaurantsViewController
                favouriteRestaurantsViewController.restaurantViewModel = favouriteRestaurantsViewModel
            }
        }
    }
    
    func сonfigureAllRestaurantsViewController(tabBarController: UITabBarController,restaurantStore: RestaurantStore) {
        let allRestaurantsViewModel = AllRestaurantsViewModel(restaurantStore: restaurantStore)
        let restaurantsNavigationController = tabBarController.viewControllers?.first as! UINavigationController
        if (restaurantsNavigationController.viewControllers.first?.isKind(of: RestaurantsViewController.self) ?? false){
            let restaurantsViewController = restaurantsNavigationController.viewControllers.first as! RestaurantsViewController
            restaurantsViewController.restaurantViewModel = allRestaurantsViewModel
        }
    }
}
