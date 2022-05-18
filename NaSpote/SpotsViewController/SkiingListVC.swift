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
    var searcController = UISearchController(searchResultsController: nil)

    var skiingList = [WakeboardModelTest]()
    var filteredSkiingList = [WakeboardModelTest]()
    var searchBarIsEmpty: Bool {
        guard let text = searcController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searcController.isActive && !searchBarIsEmpty
    }
    
    var skiingManager = WakeboardManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searcController.searchResultsUpdater = self
        searcController.obscuresBackgroundDuringPresentation = false
        searcController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searcController
        definesPresentationContext = true

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
        
        self.menuBarButtonItem.target = revealViewController()
        self.menuBarButtonItem.action = #selector(self.revealViewController()?.revealSideMenu)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredSkiingList.count
        }
        return skiingList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wakeboardListCell", for: indexPath) as! WakeboardListCell
        
        var skiing: WakeboardModelTest
        
        if isFiltering {
            skiing = filteredSkiingList[indexPath.row]
        } else {
            skiing = skiingList[indexPath.row]
        }
        
        cell.addSubview(cell.shadowView)
        cell.shadowView.addSubview(cell.logo)
        cell.shadowView.addSubview(cell.title)
        cell.shadowView.addSubview(cell.location)
        cell.shadowView.addSubview(cell.locationImage)
        cell.shadowView.addSubview(cell.rating)
        
        cell.shadowView.layer.cornerRadius = 10
        cell.shadowView.layer.borderWidth = 0.5
        
        cell.UIfontLabel(label: cell.title, font: "Helvetica-Bold", viewHeight: view.frame.height, size: 14)
        cell.UIfontLabel(label: cell.location, font: "Helvetica", viewHeight: view.frame.height, size: 7)
        
        cell.logo.kf.indicatorType = .activity
        cell.logo.kf.setImage(with: URL(string: skiing.image), placeholder: UIImage(named: "NotFound"))
        cell.title.text = skiing.title
        cell.location.text = skiing.location
        cell.locationImage.image = UIImage(systemName: "location.circle")
        cell.rating.rating = skiing.raiting.average
        
        
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
            cell.locationImage.heightAnchor.constraint(equalToConstant: 20),
            cell.locationImage.widthAnchor.constraint(equalToConstant: 20),
            
            cell.location.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            cell.location.leadingAnchor.constraint(equalTo: cell.locationImage.trailingAnchor, constant: 5),
            cell.location.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30),
            
            cell.rating.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -20),
            cell.rating.leadingAnchor.constraint(equalTo: cell.logo.trailingAnchor, constant: 10),
            cell.rating.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40)
            
        ])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let indexPath = tableView.indexPathForSelectedRow {
        let SpotCardVC = storyboard?.instantiateViewController(withIdentifier: "spotCardID") as! SpotCardVC
            SpotCardVC.link = skiingList[indexPath.row].link
            SpotCardVC.logo = skiingList[indexPath.row].image
        self.navigationController?.pushViewController(SpotCardVC, animated: true)

        }
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

extension SkiingListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredSkiingList = skiingList.filter({ (wakeboard: WakeboardModelTest) in
            return wakeboard.title.lowercased().contains(searchText.lowercased()) || wakeboard.location.lowercased().contains(searchText.lowercased())
    
        })
        tableView.reloadData()
    }
}
