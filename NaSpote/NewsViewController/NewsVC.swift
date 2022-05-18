//
//  sdfgdsfhdfghjfvghjkvhjk.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 01.05.2022.
//

import UIKit
import Kingfisher

class NewsVC: UITableViewController {
    
    var menuBarButtonItem = UIBarButtonItem()
    
    var newsManager = NewsManager()
    var newsTest = [NewsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        newsManager.delegate = self
        
        DispatchQueue.main.async {
            self.newsManager.fetchNews()
        }
        
        title = "Новости"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        menuBarButtonItem.image = UIImage(named: "menu")
        menuBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = menuBarButtonItem
        
        self.menuBarButtonItem.target = self.revealViewController()
        self.menuBarButtonItem.action = #selector(self.revealViewController()?.revealSideMenu)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTest.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cef", for: indexPath) as! NewsVCCell
        

        cell.addSubview(cell.shadowView)
        cell.shadowView.addSubview(cell.newsImage)
        cell.shadowView.addSubview(cell.newsLabel)
        cell.shadowView.makeShadow()
        
        let processor = DownsamplingImageProcessor(size: cell.bounds.size)
        
        cell.newsImage.kf.indicatorType = .activity
        cell.newsImage.kf.setImage(with: URL(string: newsTest[indexPath.row].image), placeholder: UIImage(named: "NotFound"), options: [.processor(processor)])
        cell.newsLabel.UIfontLabel(viewHeight: view.frame.height)
        cell.newsLabel.text = newsTest[indexPath.row].title
        
        NSLayoutConstraint.activate([
        
            cell.shadowView.heightAnchor.constraint(equalToConstant: cell.frame.height - 20),
            cell.shadowView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            cell.shadowView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20),
            cell.shadowView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20),
            
            cell.newsImage.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            cell.newsImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20),
            cell.newsImage.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20),
            cell.newsImage.heightAnchor.constraint(equalToConstant: cell.frame.height / 1.5),
            
            cell.newsLabel.topAnchor.constraint(equalTo: cell.newsImage.bottomAnchor, constant: 5),
            cell.newsLabel.leadingAnchor.constraint(equalTo: cell.shadowView.leadingAnchor, constant: 10),
            cell.newsLabel.trailingAnchor.constraint(equalTo: cell.shadowView.trailingAnchor, constant: -10),
            cell.newsLabel.bottomAnchor.constraint(equalTo: cell.shadowView.bottomAnchor, constant: -5)
        ])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if let indexPath = tableView.indexPathForSelectedRow {
        let detailNewsVC = storyboard?.instantiateViewController(withIdentifier: "detailNewsID") as! NewsDetailVC
            detailNewsVC.link = newsTest[indexPath.row].link
            detailNewsVC.imageNews.kf.setImage(with: URL(string: newsTest[indexPath.row].image), placeholder: nil)
        self.navigationController?.pushViewController(detailNewsVC, animated: true)
            
        }
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 2.5
    }
}

extension NewsVC: NewsManagerDelegate {
    func didUpdateNews(news: [NewsModel]) {
        self.newsTest = news
        self.tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

