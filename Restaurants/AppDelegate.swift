//
//  AppDelegate.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit
import RealmSwift



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
            if (tabBarController.viewControllers?[2].isKind(of: MapViewController.self) ?? false){
//                configureMapViewController(tabBarController: tabBarController, restaurantStore: restaurantStore)
                
            }
        }
    }
    
    func configureMapViewController(tabBarController: UITabBarController,restaurantStore: RestaurantStore) {
        let mapNavigationController = tabBarController.viewControllers?[2] as! UINavigationController
        let mapViewModel = MapViewModel(restaurantStore: restaurantStore)
        if (mapNavigationController.viewControllers.first?.isKind(of: MapViewController.self) ?? false){
            let mapViewController = mapNavigationController.viewControllers.first as! MapViewController
            mapViewController.mapViewModel = mapViewModel
        }
       // mapViewController.test()
    }
    
    func configureFavouriteViewConroller(tabBarController: UITabBarController,restaurantStore: RestaurantStore) {
        let favouriteRestaurantsViewModel = FavouriteRestaurantsViewModel(restaurantStore: restaurantStore)
        let favouriteRestaurantsNavigationController = tabBarController.viewControllers?[1] as! UINavigationController
        if ((favouriteRestaurantsNavigationController.viewControllers.first?.isKind(of: RestaurantsViewController.self)) ?? false){
            let favouriteRestaurantsViewController = favouriteRestaurantsNavigationController.viewControllers.first as! RestaurantsViewController
          //  favouriteRestaurantsViewController.loadView()
            favouriteRestaurantsViewController.restaurantViewModel = favouriteRestaurantsViewModel
           // favouriteRestaurantsViewController.reloadTableView()
        }
    }
    
    func сonfigureAllRestaurantsViewController(tabBarController: UITabBarController,restaurantStore: RestaurantStore) {
        let allRestaurantsViewModel = AllRestaurantsViewModel(restaurantStore: restaurantStore)
        let restaurantsNavigationController = tabBarController.viewControllers?.first as! UINavigationController
        if (restaurantsNavigationController.viewControllers.first?.isKind(of: RestaurantsViewController.self) ?? false){
            let restaurantsViewController = restaurantsNavigationController.viewControllers.first as! RestaurantsViewController
            restaurantsViewController.restaurantViewModel = allRestaurantsViewModel
//            restaurantsViewController.reloadTableView()
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
