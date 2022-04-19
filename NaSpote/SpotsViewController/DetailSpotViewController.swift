//
//  DetailSpotViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 30.03.2022.
//

import UIKit
import MapKit

protocol showHideButtons {
    
    func didUpdateScrollPosition(position: Int)
    
}

class DetailSpotViewController: UITableViewController {
    
    var delegate: showHideButtons?
    
    let spotGalleryArray = ["funwake1", "funwake2", "funwake3", "funwake4"]
    let infoArray = ["Реверсивная лебедка",
                     "Оплата картой",
                     "Душ",
                     "Кафе",
                     "Wi-Fi",
                     "Батут",
                     "Кольцевая лебедка",
                     "Парковка",
                     "Сауна/Баня",
                     "Бар",
                     "Номера"]
    
    
    @IBOutlet var logoCell: UITableViewCell!
    
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
    let count = 14

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spotGallery.delegate = self
        spotGallery.dataSource = self
        
        logoCellConfiguration()
        contactCellConfiguration()
        infoCellConfiguration()
        logoCellConfiguration()
        tableView.reloadData()
        
        delegate?.didUpdateScrollPosition(position: count)
        

    }
    
    func delgetevc() {
        delegate?.didUpdateScrollPosition(position: count)
    }
    
    func logoCellConfiguration() {
        titleLabel.text = "FunWake 33"
        titleLabel.font = .boldSystemFont(ofSize: 25)
        logo.layer.cornerRadius = logo.frame.height / 2

        logo.layer.masksToBounds = true
        logo.image = UIImage(named: "funwake5")
    }
    
    func contactCellConfiguration() {
        
        weekdayTitle.text = "Цена за сет в будни" + ":"
        weekdayContent.text = "500,00 RUB"
        weekendTitle.text = "Цена за сет в выходные" + ":"
        weekendContent.text = "500,00 RUB"
        setDurationTitle.text = "Длительность сета" + ":"
        setDurationContent.text = "10 минут"
        workHoursTitle.text = "Время работы" + ":"
        workHoursContent.text = "по будням: с 10:00 до 22:00 выходные: с 10.00 до 22.00"
        
    }
    
    func infoCellConfiguration() {
        
        for i in info {
            i.text = ""
            i.font = .boldSystemFont(ofSize: 13.0)
        }
        
        for (i, j) in zip(info, infoArray) {
            i.text = j
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
    
}


extension DetailSpotViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotGalleryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! DetailWakeboardGalleryCell
        
//        let image = self.spotGallery[indexPath.row]
//        let downloadImage = URL(string: image)
//        let resourses = ImageResource(downloadURL: downloadImage!)
//        let processor = DownsamplingImageProcessor(size: cell.galleryImageView.bounds.size)
//
//        cell.galleryImageView.kf.indicatorType = .activity
//        cell.galleryImageView.kf.setImage(with: resourses, placeholder: nil, options: [.processor(processor)]) { (result) in  }
//
        
        cell.galleryImageView.image = UIImage(named: self.spotGalleryArray[indexPath.row])
        
        return cell
    }
    
}

extension DetailSpotViewController {
    

    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            positionScroll = scrollView.contentOffset
 
        var position = Bool()
//        print(velocity.y)

        
//        self.delegate?.didUpdateScrollPosition(position: scrollView.contentOffset.y)
        
        if positionScroll.y < 0 {
            position = true
            NotificationCenter.default.post(name: Notification.Name("false"), object: nil)
        } else {
            position = false
            NotificationCenter.default.post(name: Notification.Name("true"), object: nil)
        }

        tableView.reloadData()
    }

}
