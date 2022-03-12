//
//  DetailNewsVC.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 04.12.2021.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    var detailNewsManager = DetailNewsManager()
    
    var newsString = String()
    var txt = ""
    var img = ""
    var image: UIImage {
        let image = self.img
        let imageUrl = URL(string: image)
        let imageData = try? Data(contentsOf: imageUrl!)
        return  UIImage(data: imageData!)!
    }
    
    @IBOutlet var newsTxt: UITextView!
    @IBOutlet var newsImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailNewsManager.delegate = self
            DispatchQueue.main.async {
                self.detailNewsManager.fetchNews(self.txt)
                self.newsTxt.text = self.newsString
            }
        newsTxt.showsVerticalScrollIndicator = false
        newsImg.image = image
    }
}

extension DetailNewsViewController: DetailNewsManagerDelegate {
    func didUpdateNews(teams: DetailNewsModel) {
        self.newsString = teams.textNews
    }


    func didFailWithError(error: Error) {
        print(error)
    }
}
