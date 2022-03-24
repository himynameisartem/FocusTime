//
//  TableNewsVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 03.12.2021.
//

import UIKit
import SwiftSoup
import Kingfisher

class NewsViewController: UITableViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var newsManager = NewsManager()
    var newsTest = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false
        newsManager.delegate = self
        
        DispatchQueue.main.async {
            self.newsManager.fetchNews()
        }
        
        self.sideMenuBtn.target = self.revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
    }
    
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTest.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let image = newsTest[indexPath.row].image
        let downloadUrl = URL(string: image)
        let resourse = ImageResource(downloadURL: downloadUrl!)
        let processor = DownsamplingImageProcessor(size: cell.newsImage.bounds.size)
        
        cell.newsImage.kf.indicatorType = .activity
        cell.newsImage.kf.setImage(with: resourse, options: [.processor(processor)])
        cell.newsLabel.text = newsTest[indexPath.row].title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let detailNewsVC = segue.destination as! DetailNewsViewController
            detailNewsVC.txt = newsTest[indexPath.row].link
            detailNewsVC.img = newsTest[indexPath.row].image
        }
    }
}

// MARK: MaagerDelegate

extension NewsViewController: NewsManagerDelegate {
    func didUpdateNews(news: [NewsModel]) {
        self.newsTest = news
        self.tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}



