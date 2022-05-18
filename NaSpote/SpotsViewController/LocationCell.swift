//
//  LocationCell.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 14.05.2022.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {
    
    var map = MKMapView()    
    let geocoder = CLGeocoder()


    override func awakeFromNib() {
        super.awakeFromNib()
        
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 7
        map.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension LocationCell {
    
    func location(_ location: String, _ map: MKMapView) {
        geocoder.geocodeAddressString(location) { (placemarks, error)
            in
            if error != nil {
                print(error!)
            }
            if placemarks != nil {
                if let placemark = placemarks?.first {
                    let annotation = MKPointAnnotation()
                    annotation.title = location
                    annotation.coordinate = placemark.location!.coordinate
                    
                    map.showAnnotations([annotation], animated: true)
                    map.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
}
