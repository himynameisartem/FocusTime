//
//  LocationSpotSnowViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 12.01.2022.
//

import UIKit
import MapKit

class LcationSnowboardViewController: UIViewController {
    
    @IBOutlet var map: MKMapView!
    
    let geocoder = CLGeocoder()
    var locationString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location(locationString)
        
    }
    
    func location(_ location: String) {
        geocoder.geocodeAddressString(location) { (placemarks, error)
            in
            if error != nil {
                print(error!)
            }
            if placemarks != nil {
                if let placemark = placemarks?.first {
                    let annotation = MKPointAnnotation()
                    annotation.title = "naspote"
                    annotation.coordinate = placemark.location!.coordinate
                    
                    self.map.showAnnotations([annotation], animated: true)
                    self.map.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
}
