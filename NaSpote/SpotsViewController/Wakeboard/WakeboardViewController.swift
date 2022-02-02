//
//  SpotVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import UIKit
import SwiftSoup

class WakeboardViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var spotManager = WakeboardManager()
    
    var spotImage = [String]()
    var spotTitle = [String]()
    var spotMap = [String]()
    var spotLink = [String]()
    
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
        
        return spotImage.count
    }
    
    @IBAction func mapTouch(_ sender: UIButton) {
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotIdentifire", for: indexPath) as! WakeboardCell
        
        DispatchQueue.global(qos: .utility).async {
            let image = self.spotImage[indexPath.row]
            let imageUrl = URL(string: image)
            let imageData = try? Data(contentsOf: imageUrl!)
            
            DispatchQueue.main.async {
                
                cell.spotImage.image = UIImage(data: imageData!)
                cell.spotTitle.text = self.spotTitle[indexPath.row]
                
            }
        }
        cell.mapButton.setTitle(self.spotMap[indexPath.row], for: .normal)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "GoToDetailSpotVC"  {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mapVC = segue.destination as! DetailWakeboardViewController
                mapVC.spotTitle = self.spotTitle[indexPath.row]
                mapVC.spotLink = self.spotLink[indexPath.row]
                mapVC.spotImage = self.spotImage[indexPath.row]
                mapVC.locationString = self.spotMap[indexPath.row]
            }
        }
                
        if segue.identifier == "GoToMapVC" {
            let mapVC = segue.destination as! LocationWakeboardViewController
            if let buttonTitle = (sender as? UIButton)?.titleLabel?.text {
                mapVC.locationString = buttonTitle
                
            }
            
        }
    }
}

extension WakeboardViewController: SpotManagerDelegate {
    func didUpdateNews(spot: WakeboardModel) {
        self.spotImage = spot.spotImage
        self.spotTitle = spot.spotTitle
        self.spotMap = spot.spotMap
        self.spotLink = spot.spotLink
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
