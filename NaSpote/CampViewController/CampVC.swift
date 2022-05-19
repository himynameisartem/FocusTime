//
//  CampVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 19.05.2022.
//

import UIKit

class CampVC: UITableViewController {
    
    let posterArray = ["camp1", "camp2"]
    
    var menuButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Кемпы"
        
        menuButton.image = UIImage(named: "menu")
        menuButton.tintColor = .black
        navigationItem.leftBarButtonItem = menuButton
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posterArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "campCell", for: indexPath) as! CampCell
        
        cell.addSubview(cell.shadowView)
        cell.shadowView.addSubview(cell.poster)
        cell.poster.image = UIImage(named: posterArray[indexPath.row])
        
        NSLayoutConstraint.activate([
        
            cell.shadowView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 20),
            cell.shadowView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20),
            cell.shadowView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20),
            cell.shadowView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -10),
            cell.shadowView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.8),
            
            cell.poster.topAnchor.constraint(equalTo: cell.shadowView.topAnchor),
            cell.poster.leadingAnchor.constraint(equalTo: cell.shadowView.leadingAnchor),
            cell.poster.trailingAnchor.constraint(equalTo: cell.shadowView.trailingAnchor),
            cell.poster.bottomAnchor.constraint(equalTo: cell.shadowView.bottomAnchor)
        
        ])

        return cell
    }
}
