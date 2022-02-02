//
//  CollectionViewController.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 21.11.2021.
//

import UIKit
import SwiftSoup

private let reuseIdentifier = "Cell"

class NewsVC: UICollectionViewController {
    
    var newsManager = NewsManager()
    
    var newsString = [String]()
    var newsImage = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        newsManager.fetchNews()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsString.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let image = newsImage[indexPath.row]
        let imageUrl = URL(string: image)
        let imageData = try? Data(contentsOf: imageUrl!)
        
        cell.labelNews.text = newsString[indexPath.row]
        cell.imageNews.image = UIImage(data: imageData!)
        
        return cell
    }
    
}


extension NewsVC: NewsManagerDelegate {
    func didUpdateNews(teams: NewsModel) {
        self.newsString = teams.newsString
        self.newsImage = teams.newsImage
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
