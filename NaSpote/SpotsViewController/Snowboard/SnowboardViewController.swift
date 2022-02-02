//
//  SpotSnowViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 09.01.2022.
//

import UIKit
import SwiftSoup

class SnowboardViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var spotManager = SnowboardManager()
    
    var spotTitle = [String]()
    var spotMap = [String]()
    var spotLink = [String]()
    var spotImg = [UIImage]()
    
    var spotCell = WakeboardCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spotManager.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.spotManager.fetchSpot()
            self.tableView.reloadData()
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
        
            DispatchQueue.main.async {
                cell.spotImage.image = self.spotImg[indexPath.row]
                cell.spotTitle.text = self.spotTitle[indexPath.row]
            }
        
        cell.spotTitle.text = self.spotTitle[indexPath.row]
        
        cell.mapButton.setTitle(self.spotMap[indexPath.row], for: .normal)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "GoToDetailSnowboardVC"  {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mapVC = segue.destination as! DetailSnowboardViewController
                mapVC.spotTitle = self.spotTitle[indexPath.row]
                mapVC.spotLink = self.spotLink[indexPath.row]
                mapVC.locationString = self.spotMap[indexPath.row]
                mapVC.spotImage = self.spotImg[indexPath.row]
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
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

