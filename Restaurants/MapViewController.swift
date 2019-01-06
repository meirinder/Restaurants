//
//  MapViewController.swift
//  Restaurants
//
//  Created by Savely on 12.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var mapViewModel: MapViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        test()
        // Do any additional setup after loading the view.
    }
    
    func test() {
        let annots  = mapViewModel!.buildAnnotations()
        for ann in annots{
            self.mapView.addAnnotation(ann)
        }
        self.mapView.showAnnotations(annots, animated: true )
        
        let restaurantsLocation = CLLocationCoordinate2D(latitude: 55.018803, longitude: 82.933952)
        mapView.setCenter(restaurantsLocation, animated: true)
        mapView.camera.altitude = 150000
        
    }
    
    @objc
    func pushDetails(){
        if let navController = self.navigationController, let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            
            let restaurantAtIndexPath = mapViewModel!.restaurantStore.restaurants()[(mapViewModel?.searchIndex())!]
            let localRestaurantStore = RestaurantStore(restaurants: [restaurantAtIndexPath])
            let localDetailViewModel = DetailViewModel(restaurantStore: localRestaurantStore)
            viewController.detailViewModel = localDetailViewModel
            navController.pushViewController(viewController, animated: true)
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapViewModel?.currentTitle = ((view.annotation?.title)!)!
        print("Select annotatiton = \(String(describing: view.annotation?.title))")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        annotationView?.canShowCallout = true
        annotationView?.frame=CGRect(x: 0, y: 0, width: 10, height: 10)
        annotationView?.layer.cornerRadius = (annotationView?.frame.height)!/2
        annotationView?.backgroundColor=UIColor.red
        
        let button = UIButton()
        button.backgroundColor = .blue
        let viewForButton = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.frame = CGRect(x: viewForButton.frame.width/2-35, y: viewForButton.frame.height/2-15, width: 70, height: 30)
        button.setTitle("Detials", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        
        button.addTarget(self, action: #selector(pushDetails), for: .touchUpInside)
        viewForButton.addSubview(button)
        
        annotationView?.rightCalloutAccessoryView = viewForButton
        
        return annotationView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
