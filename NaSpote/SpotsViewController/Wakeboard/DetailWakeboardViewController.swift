//
//  DetailSpotViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.01.2022.
//

import UIKit
import MapKit

class DetailWakeboardViewController: UIViewController {
    
    var spotTitle = ""
    var spotLink = ""
    var spotImage = ""
    var info = ""
    var locationString = ""
    
    var infoSpot = [String]()
    var contactsSpot = [String]()
    var spotGallery = [String]()
    
    let geocoder = CLGeocoder()
    var detailSpotManager = DetailWakeboardManager()
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var galleryCollectionView: UICollectionView!
    @IBOutlet var infoLabelCollection: [UILabel]!
    @IBOutlet var contactsLabelCollection: [UILabel]!
    @IBOutlet var locationOutlet: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location(locationString)
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        //        galleryCollectionView.register(DetailSpotGalleryCell.self, forCellWithReuseIdentifier: "galleryCell")
        
        DispatchQueue.main.async {
            self.detailSpotManager.delegate = self
            self.detailSpotManager.fetchSpot(self.spotLink)
            self.createInfo()
            self.createContacts()
            self.galleryCollectionView.reloadData()
        }
        
        
        navigationItem.title = spotTitle
        
        for i in infoLabelCollection {
            i.text = ""
        }
        
        for i in contactsLabelCollection {
            i.text = ""
        }
        
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.cornerRadius = logoImageView.frame.size.width / 2
        
        let imageUrl = URL(string: spotImage)
        let imageData = try? Data(contentsOf: imageUrl!)
        logoImageView.image = UIImage(data: imageData!)
        
    }
    
    func createInfo() {
        for i in infoLabelCollection {
            i.text = ""
        }
        
        for (i,j) in zip(infoSpot, infoLabelCollection) {
            j.text = "- \(i)"
        }
    }
    
    func createContacts() {
        
        for (i,j) in zip(contactsSpot, contactsLabelCollection) {
            j.text = "- \(i)"
        }
        
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
                
                self.locationOutlet.showAnnotations([annotation], animated: true)
                self.locationOutlet.selectAnnotation(annotation, animated: true)
            }
        }
    }
}
}

extension DetailWakeboardViewController: DetailSpotManagerDelegate {
    func didUpdateSpot(spot: DetailWakeboardModel) {
        self.infoSpot = spot.info
        self.contactsSpot = spot.contacts
        self.spotGallery = spot.gallery
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension DetailWakeboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = (self.view.frame.size.width - 12 * 3) / 3 //some width
        //            let height = width * 1.5 //ratio
        return CGSize(width: 350, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! DetailWakeboardGalleryCell
        
        DispatchQueue.global(qos: .utility).async {
            let image = self.spotGallery[indexPath.row]
            let imageUrl = URL(string: image)
            let imageData = try? Data(contentsOf: imageUrl!)
            
            DispatchQueue.main.async {
                
                cell.galleryImageView.image = UIImage(data: imageData!)
            }
        }
        
        return cell
    }
    
}


