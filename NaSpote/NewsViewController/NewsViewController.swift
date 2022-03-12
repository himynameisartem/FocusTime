//
//  TableNewsVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 03.12.2021.
//

import UIKit
import SwiftSoup

class NewsViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var newsManager = NewsManager()
    
    var newsString = [String]()
    var newsImage = [String]()
    var newsLink = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false
        newsManager.delegate = self
        
        DispatchQueue.main.async {
            self.sideMenuBtn.target = self.revealViewController()
            self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
            self.newsManager.fetchNews()
            self.tableView.reloadData()
        }
    }

    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsString.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        DispatchQueue.global(qos: .utility).async {
            let image = self.newsImage[indexPath.row]
            let imageUrl = URL(string: image)
            let imageData = try? Data(contentsOf: imageUrl!)
            
            DispatchQueue.main.async {
                
                cell.newsImage.image = UIImage(data: imageData!)
            }
        }
        
        cell.newsLabel.text = self.newsString[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
          
            let detailNewsVC = segue.destination as! DetailNewsViewController
            detailNewsVC.txt = newsLink[indexPath.row]
            detailNewsVC.img = newsImage[indexPath.row]
        }
    }
}

// MARK: MaagerDelegate

extension NewsViewController: NewsManagerDelegate {
    func didUpdateNews(news: NewsModel) {
        self.newsString = news.newsString
        self.newsImage = news.newsImage
        self.newsLink = news.newsLink
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}



