//
//  SpotVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import UIKit
import SwiftSoup
import Kingfisher

class WakeboardViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    var spotManager = WakeboardManager()
    var wakeboard = [WakeboardModelTest]()

    var spotCell = WakeboardCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spotManager.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.spotManager.fetchSpot()
        }
        
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
    }
    
 
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wakeboard.count
    }
    
    @IBAction func mapTouch(_ sender: UIButton) {
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotIdentifire", for: indexPath) as! WakeboardCell
        
        let image = wakeboard[indexPath.row].image
        let downloadURL = URL(string: image)
        let resourses = ImageResource(downloadURL: downloadURL!)
        
        cell.spotImage.kf.indicatorType = .activity
        cell.spotImage.kf.setImage(with: resourses, placeholder: nil, options: nil) { (result) in }
        cell.spotTitle.text = wakeboard[indexPath.row].title
        cell.mapButton.setTitle(wakeboard[indexPath.row].location, for: .normal)
        cell.spotPhone.text = wakeboard[indexPath.row].phone
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailSpotVC"  {
            if let indexPath = tableView.indexPathForSelectedRow {
                let mapVC = segue.destination as! DetailWakeboardViewController
                mapVC.spotTitle = wakeboard[indexPath.row].title
                mapVC.spotLink = wakeboard[indexPath.row].link
                mapVC.spotImage = wakeboard[indexPath.row].image
                mapVC.locationString = wakeboard[indexPath.row].location
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
    func didUpdateNews(spot: [WakeboardModelTest]) {
        wakeboard = spot
        self.tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
