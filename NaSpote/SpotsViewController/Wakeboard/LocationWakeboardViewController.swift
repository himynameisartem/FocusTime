//
//  mapVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 08.12.2021.
//

import UIKit
import MapKit

class LocationWakeboardViewController: UIViewController {
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
