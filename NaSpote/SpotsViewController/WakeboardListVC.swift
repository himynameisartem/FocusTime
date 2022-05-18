//
//  WakeboardListVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 03.05.2022.
//

import UIKit
import Kingfisher
import MapKit

class WakeboardListVC: UITableViewController {
    
    let menuBarButtonItem = UIBarButtonItem()
    let sortingBarButtonItem = UIBarButtonItem()
    
    var searcController = UISearchController(searchResultsController: nil)
    
    var wakeboardList = [WakeboardModelTest]()
    var filteredWakeboardList = [WakeboardModelTest]()
    var searchBarIsEmpty: Bool {
        guard let text = searcController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searcController.isActive && !searchBarIsEmpty
    }
    
    var wakeboardManager = WakeboardManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searcController.searchResultsUpdater = self
        searcController.obscuresBackgroundDuringPresentation = false
        searcController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searcController
        definesPresentationContext = true
        
        wakeboardManager.delegate = self
        
        DispatchQueue.main.async {
            self.wakeboardManager.fetchSpot("https://naspote.fun/%d0%b2%d0%b5%d0%b9%d0%ba%d0%b1%d0%be%d1%80%d0%b4/")
        }

        title = "Вейкборд"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        menuBarButtonItem.image = UIImage(named: "menu")
        menuBarButtonItem.tintColor = .black
        sortingBarButtonItem.image = UIImage(systemName: "arrow.up.arrow.down")
        sortingBarButtonItem.tintColor = .black
        sortingBarButtonItem.action = #selector(sortedButtonTapped)
        sortingBarButtonItem.target = self
        navigationItem.rightBarButtonItem = sortingBarButtonItem
        navigationItem.leftBarButtonItem = menuBarButtonItem
        
        
        tableView.separatorStyle = .none
        
        self.menuBarButtonItem.target = revealViewController()
        self.menuBarButtonItem.action = #selector(self.revealViewController()?.revealSideMenu)
    }

    @objc func sortedButtonTapped() {
        let alert = UIAlertController(title: "Сортировать по:", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel)
        let raitingAction = UIAlertAction(title: "Рейтингу", style: .default)
        let cableTypeAction = UIAlertAction(title: "Кабельный вейкборд", style: .default)
        let boatTypeAction = UIAlertAction(title: "Катерный вейкборд", style: .default)
        
        alert.addAction(cancelAction)
        alert.addAction(raitingAction)
        alert.addAction(cableTypeAction)
        alert.addAction(boatTypeAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredWakeboardList.count
        }
        return wakeboardList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wakeboardListCell", for: indexPath) as! WakeboardListCell
        
        var wakeboard: WakeboardModelTest
        
        if isFiltering {
            wakeboard = filteredWakeboardList[indexPath.row]
        } else {
            wakeboard = wakeboardList[indexPath.row]
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
        cell.logo.kf.setImage(with: URL(string: wakeboard.image), placeholder: UIImage(named: "NotFound"))
        cell.title.text = wakeboard.title
        cell.location.text = wakeboard.location
        cell.locationImage.image = UIImage(systemName: "location.circle")
        cell.rating.rating = wakeboard.raiting.average
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let indexPath = tableView.indexPathForSelectedRow {
        let SpotCardVC = storyboard?.instantiateViewController(withIdentifier: "spotCardID") as! SpotCardVC
            SpotCardVC.link = wakeboardList[indexPath.row].link
            SpotCardVC.logo = wakeboardList[indexPath.row].image
        self.navigationController?.pushViewController(SpotCardVC, animated: true)

        }
    }
    
}

extension WakeboardListVC: SpotManagerDelegate {
    func didUpdateNews(spot: [WakeboardModelTest]) {
        self.wakeboardList = spot
        self.tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - SearchResultUpdating

extension WakeboardListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredWakeboardList = wakeboardList.filter({ (wakeboard: WakeboardModelTest) in
            return wakeboard.title.lowercased().contains(searchText.lowercased()) || wakeboard.location.lowercased().contains(searchText.lowercased())

    })
        tableView.reloadData()
    }
}



