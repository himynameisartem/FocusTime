//
//  DetailSpotViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.01.2022.
//

import UIKit
import MapKit
import Kingfisher

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
    @IBOutlet var shadowView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location(locationString)
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        shadowView.layer.cornerRadius = 10
        shadowView.makeShadow()
        
        resizeFont()
        
        
        DispatchQueue.main.async {
            self.detailSpotManager.delegate = self
            self.detailSpotManager.fetchSpot(self.spotLink)
            self.createInfo()
            self.createContacts()
            self.galleryCollectionView.reloadData()
            
            self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width/2
            self.logoImageView.clipsToBounds = true
            self.logoImageView.layer.borderWidth = 0.5
        }
        
        if spotImage == "NotFound" {
            logoImageView.image = UIImage(named: "NotFound")
        } else {
        let imageUrl = URL(string: spotImage)
        let resourses = ImageResource(downloadURL: imageUrl!)
        let processor = RoundCornerImageProcessor(cornerRadius: logoImageView.frame.size.width/2)
        logoImageView.kf.indicatorType = .activity
        logoImageView.kf.setImage(with: resourses, placeholder: nil, options: [.processor(processor)]) { (result) in  }
        }
        
        navigationItem.title = spotTitle
        
        for i in infoLabelCollection {
            i.text = ""
        }
        
        for i in contactsLabelCollection {
            i.text = ""
        }
    }
    
    func createInfo() {
        for (i,j) in zip(infoSpot, infoLabelCollection) {
            j.text = "- \(i)"
        }
    }
    
    func createContacts() {
        for (i,j) in zip(contactsSpot, contactsLabelCollection) {
            j.text = "- \(i)"
        }
    }
    
    func resizeFont() {
        
        let screenWidth = view.frame.width
        if screenWidth < CGFloat(400.0) {
            for i in contactsLabelCollection {
                i.font = UIFont(name: "Helvetica", size: 8.0)
                
            }
            for i in infoLabelCollection {
                i.font = UIFont.boldSystemFont(ofSize: 11.0)
            }
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
        return CGSize(width: 240, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! DetailWakeboardGalleryCell
        
        let image = self.spotGallery[indexPath.row]
        let downloadImage = URL(string: image)
        let resourses = ImageResource(downloadURL: downloadImage!)
        let processor = DownsamplingImageProcessor(size: cell.galleryImageView.bounds.size)
        
        cell.galleryImageView.kf.indicatorType = .activity
        cell.galleryImageView.kf.setImage(with: resourses, placeholder: nil, options: [.processor(processor)]) { (result) in  }
        
        
        return cell
    }
    
}


