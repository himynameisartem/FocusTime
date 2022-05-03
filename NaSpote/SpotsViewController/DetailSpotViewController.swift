//
//  DetailSpotViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 30.03.2022.
//

import UIKit
import MapKit
import Kingfisher


class DetailSpotViewController: UITableViewController {
    
    var contacts: Contacts!
    
    var detailWakeboarManager = DetailWakeboardManager()
    
    @IBOutlet var logoCell: UITableViewCell!
    @IBOutlet var contactsCell: UITableViewCell!
    @IBOutlet var galleryCell: UITableViewCell!
    @IBOutlet var infoCell: UITableViewCell!
    @IBOutlet var locationCell: UITableViewCell!
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var logo: UIImageView!
    
    @IBOutlet var weekdayTitle: UILabel!
    @IBOutlet var weekdayContent: UILabel!
    @IBOutlet var weekendTitle: UILabel!
    @IBOutlet var weekendContent: UILabel!
    @IBOutlet var setDurationTitle: UILabel!
    @IBOutlet var setDurationContent: UILabel!
    @IBOutlet var workHoursTitle: UILabel!
    @IBOutlet var workHoursContent: UILabel!
    
    @IBOutlet var spotGallery: UICollectionView!
    
    @IBOutlet var info: [UILabel]!
    
    @IBOutlet var location: MKMapView!
    
    var positionScroll = CGPoint()
    let geocoder = CLGeocoder()
    
    var logoString = String()
    var link = String()
    var test = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spotGallery.delegate = self
        spotGallery.dataSource = self
        detailWakeboarManager.delegate = self

        detailWakeboarManager.fetchSpot(link)
        
        logoCellConfiguration()
        infoCellConfiguration()
        contactCellConfiguration()
        location(contacts.location)
        
        
        
        tableView.reloadData()
        
        location.layer.borderWidth = 0.3
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func logoCellConfiguration() {
        
        titleLabel.text = contacts.title
        titleLabel.font = .boldSystemFont(ofSize: 25)
        logo.layer.cornerRadius = logo.frame.height / 2
        logo.layer.borderWidth = 0.5
        logo.layer.masksToBounds = true
        //        logo.image = UIImage(named: "funwake5")
        
        let image = logoString
        let downloadImage = URL(string: image)
        let resourses = ImageResource(downloadURL: downloadImage!)
        let processor = DownsamplingImageProcessor(size: logo.bounds.size)
        
        logo.kf.indicatorType = .activity
        logo.kf.setImage(with: resourses, placeholder: nil, options: [.processor(processor)]) { (result) in  }
        
    }
    
    func contactCellConfiguration() {
        
        
        
        weekdayTitle.isHidden = true
        weekdayContent.isHidden = true
        weekendTitle.isHidden = true
        weekendContent.isHidden = true
        setDurationTitle.isHidden = true
        setDurationContent.isHidden = true
        workHoursTitle.isHidden = true
        workHoursContent.isHidden = true
        
        if !contacts.weekday.title.isEmpty {
            weekdayTitle.isHidden = false
            weekdayTitle.text = contacts.weekday.title
            weekdayContent.isHidden = false
            weekdayContent.text = contacts.weekday.price
        }
        
        
        if !contacts.weekend.title.isEmpty {
            weekendTitle.isHidden = false
            weekendTitle.text = contacts.weekend.title
            weekendContent.isHidden = false
            weekendContent.text = contacts.weekend.price
        }
        
        if !contacts.setDuration.title.isEmpty {
            setDurationTitle.isHidden = false
            setDurationTitle.text = contacts.setDuration.title
            setDurationContent.isHidden = false
            setDurationContent.text = contacts.setDuration.duration
        }
        
        
        if  !contacts.workingHours.title.isEmpty {
            workHoursTitle.isHidden = false
            workHoursTitle.text = contacts.workingHours.title
            workHoursContent.isHidden = false
            workHoursContent.text = contacts.workingHours.hours
        }
        
    }
    
    func infoCellConfiguration() {
        
        for i in info {
            i.font = .boldSystemFont(ofSize: 13.0)
            i.isHidden = true
        }
        
        for (i, j) in zip(info, contacts.services) {
            if j != "" {
                i.isHidden = false
                i.text = j
            } else {
                i.isHidden = true
            }
        }
    }
    
    func mapConfiguration() {
        location.layer.cornerRadius = 5
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}



extension DetailSpotViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! DetailWakeboardGalleryCell
        
        
        let image = self.contacts.gallery[indexPath.row]
        let downloadImage = URL(string: image)
        let resourses = ImageResource(downloadURL: downloadImage!)
        let processor = DownsamplingImageProcessor(size: cell.galleryImageView.bounds.size)
        
        cell.galleryImageView.kf.indicatorType = .activity
        cell.galleryImageView.kf.setImage(with: resourses, placeholder: nil, options: [.processor(processor)]) { (result) in  }
        
        
        
        return cell
    }
    
}

extension DetailSpotViewController {
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        positionScroll = scrollView.contentOffset
        
        if positionScroll.y < 0 {
            NotificationCenter.default.post(name: Notification.Name("false"), object: nil)
        } else {
            NotificationCenter.default.post(name: Notification.Name("true"), object: nil)
        }
        
        tableView.reloadData()
    }
    
}

extension DetailSpotViewController: DetailSpotManagerDelegate {
    func didUpdateSpot(spot: Contacts) {
        self.contacts = spot
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension DetailSpotViewController {
    
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
                    
                    self.location.showAnnotations([annotation], animated: true)
                    self.location.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
}



