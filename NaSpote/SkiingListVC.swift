//
//  SkiingListVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 03.05.2022.
//

import UIKit
import Kingfisher

class SkiingListVC: UITableViewController {
    
    let menuBarButtonItem = UIBarButtonItem()
    
    var skiingList = [WakeboardModelTest]()
    var skiingManager = WakeboardManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        skiingManager.delegate = self
        
        DispatchQueue.main.async {
            self.skiingManager.fetchSpot("https://naspote.fun/%d0%b3%d0%be%d1%80%d0%bd%d0%be%d0%bb%d1%8b%d0%b6%d0%ba%d0%b8/")
            
        }
        
        title = "Горнолыжки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        menuBarButtonItem.image = UIImage(named: "menu")
        menuBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = menuBarButtonItem
        
        tableView.separatorStyle = .none
        
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skiingList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wakeboardListCell", for: indexPath) as! WakeboardListCell
        
        cell.addSubview(cell.shadowView)
        cell.shadowView.addSubview(cell.logo)
        cell.shadowView.addSubview(cell.title)
        cell.shadowView.addSubview(cell.location)
        cell.shadowView.addSubview(cell.phone)
        cell.shadowView.addSubview(cell.locationImage)
        cell.shadowView.addSubview(cell.phoneImage)
        
        cell.shadowView.layer.cornerRadius = 10
        cell.shadowView.layer.borderWidth = 0.5
        
        cell.UIfontLabel(label: cell.title, font: "Helvetica-Bold", viewHeight: view.frame.height, size: 14)
        cell.UIfontLabel(label: cell.location, font: "Helvetica", viewHeight: view.frame.height, size: 7)
        cell.UIfontLabel(label: cell.phone, font: "Helvetica", viewHeight: view.frame.height, size: 15)
        
        cell.logo.kf.indicatorType = .activity
        cell.logo.kf.setImage(with: URL(string: skiingList[indexPath.row].image), placeholder: UIImage(named: "NotFound"))
        cell.title.text = skiingList[indexPath.row].title
        cell.location.text = skiingList[indexPath.row].location
        cell.phone.text = skiingList[indexPath.row].phone
        cell.locationImage.image = UIImage(systemName: "location.circle")
        cell.phoneImage.image = UIImage(systemName: "phone.down.circle")
        
        
        NSLayoutConstraint.activate([
        
            cell.shadowView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            cell.shadowView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20),
            cell.shadowView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20),
            cell.shadowView.heightAnchor.constraint(equalToConstant: cell.frame.height - 20),
            
            cell.logo.topAnchor.constraint(equalTo: cell.topAnchor, constant: 20),
            cell.logo.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 30),
            cell.logo.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -20),
            cell.logo.widthAnchor.constraint(equalToConstant: cell.frame.height - 40),
            
            cell.title.topAnchor.constraint(equalTo: cell.topAnchor, constant: 20),
            cell.title.leadingAnchor.constraint(equalTo: cell.logo.trailingAnchor, constant: 10),
            cell.title.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40),
            
            cell.locationImage.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            cell.locationImage.leadingAnchor.constraint(equalTo: cell.logo.trailingAnchor, constant: 10),
            cell.locationImage.heightAnchor.constraint(equalToConstant: cell.phone.font.pointSize + 3),
            cell.locationImage.widthAnchor.constraint(equalToConstant: cell.phone.font.pointSize + 3),
            
            cell.location.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            cell.location.leadingAnchor.constraint(equalTo: cell.locationImage.trailingAnchor, constant: 5),
            cell.location.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30),
            
            cell.phoneImage.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -20),
            cell.phoneImage.leadingAnchor.constraint(equalTo: cell.logo.trailingAnchor, constant: 10),
            cell.phoneImage.heightAnchor.constraint(equalToConstant: cell.phone.font.pointSize + 3),
            cell.phoneImage.widthAnchor.constraint(equalToConstant: cell.phone.font.pointSize + 3),
            
            cell.phone.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -20),
            cell.phone.leadingAnchor.constraint(equalTo: cell.phoneImage.trailingAnchor, constant: 5),
            cell.phone.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40)
            
        ])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch view.frame.height {
        case 548.0...568.0:
            return CGFloat(120)//iPhone 5S,SE
        case 647.0...667.0:
            return CGFloat(130)//iPhone 6,7,8
        case 716.0...736.0:
            return CGFloat(140)//iPhone 6+,7+,8+
        case 792...812.0:
            return CGFloat(150)//iPhone X,XS,XR
        case 876.0...896.0:
            return CGFloat(150)//iPhone XS_Max
        default: return CGFloat(150)
        }
    }
    
}


extension SkiingListVC: SpotManagerDelegate {
    func didUpdateNews(spot: [WakeboardModelTest]) {
        self.skiingList = spot
        self.tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
