//
//  DetailSpotViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 30.03.2022.
//

import UIKit

class DetailSpotViewController: UITableViewController {

    @IBOutlet var logoCell: UITableViewCell!
    
    let detailSpotManager = DetailWakeboardManager()
    var spot = [Contacts]()
    
    let url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailSpotManager.fetchSpot(url)

        logoCellConfiguration()
       
    }

    func logoCellConfiguration() {
        
        var configuration = logoCell.defaultContentConfiguration()
        configuration.image = UIImage(named: "logo")
        configuration.imageProperties.maximumSize = CGSize(width: 90.0, height: 90.0)
        configuration.imageProperties.cornerRadius = tableView.rowHeight / 2
        configuration.text = "Funwake 33"
        configuration.textProperties.font = .boldSystemFont(ofSize: 20)
        
        logoCell.contentConfiguration = configuration
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}

extension DetailSpotViewController: DetailSpotManagerDelegate {
    func didUpdateSpot(spot: [Contacts]) {
        self.spot = spot
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
