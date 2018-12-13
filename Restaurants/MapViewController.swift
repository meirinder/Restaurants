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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       
        // Do any additional setup after loading the view.
    }
    
    func test() {
        let ann  = mapViewModel!.buildAnnotations()
        self.mapView.showAnnotations(ann, animated: true )
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
