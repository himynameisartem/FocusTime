//
//  SpotSnowViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 09.01.2022.
//

import UIKit
import SwiftSoup
import Kingfisher

class SnowboardViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var spotManager = SnowboardManager()
    
    var spotTitle = [String]()
    var spotMap = [String]()
    var spotLink = [String]()
    var spotImg = [String]()
    
    var snowboardTest = SnowboardModel(spotTitle: [String()], spotMap: [String()], spotLink: [String()], spotImg: [String()])
    
    var spotCell = WakeboardCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spotManager.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.spotManager.fetchSpot()
            self.tableView.reloadData()
            print(self.snowboardTest.spotImg)
        }
        
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return spotImg.count
    }
    
    @IBAction func mapTouch(_ sender: UIButton) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotSnowIdentifire", for: indexPath) as! SnowboardCell
        let image = spotImg[indexPath.row]
        print(image)
        
        cell.spotImage.kf.indicatorType = .activity
        if image == "NotFound" {
            cell.spotImage.image = UIImage(named: "NotFound")
        } else {
            let downloadUrl = URL(string: image)
            let resourse = ImageResource(downloadURL: downloadUrl!)
            let processor = DownsamplingImageProcessor(size: cell.spotImage.bounds.size)
            cell.spotImage.kf.setImage(with: resourse, placeholder: nil, options: [.processor(processor)]) { (result) in }
        }
        
        cell.spotTitle.text = self.snowboardTest.spotTitle[indexPath.row]
        cell.mapButton.setTitle(self.spotMap[indexPath.row], for: .normal)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "GoToDetailVC"  {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailSpotVC = segue.destination as! DetailWakeboardViewController
                detailSpotVC.spotTitle = self.spotTitle[indexPath.row]
                detailSpotVC.spotLink = self.spotLink[indexPath.row]
                detailSpotVC.locationString = self.spotMap[indexPath.row]
                detailSpotVC.spotImage = self.spotImg[indexPath.row]
            }
        }
        
        if segue.identifier == "GoToSpotSnowMapVC" {
            let mapVC = segue.destination as! LcationSnowboardViewController
            if let buttonTitle = (sender as? UIButton)?.titleLabel?.text {
                mapVC.locationString = buttonTitle
            }
            
        }
    }
}

extension SnowboardViewController: SpotSnowManagerDelegate {
    func didUpdateNews(spot: SnowboardModel) {
        self.spotTitle = spot.spotTitle
        self.spotMap = spot.spotMap
        self.spotLink = spot.spotLink
        self.spotImg = spot.spotImg
        self.snowboardTest = SnowboardModel(spotTitle: spot.spotTitle, spotMap: spot.spotMap, spotLink: spot.spotLink, spotImg: spot.spotImg)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

