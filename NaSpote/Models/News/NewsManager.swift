//
//  NewsManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 21.11.2021.
//

import Foundation
import SwiftSoup
import UIKit
import Kingfisher
import SwiftUI

protocol NewsManagerDelegate {
    func didUpdateNews(news: [NewsModel])
    func didFailWithError(error: Error)
}

struct NewsManager {
    
    var delegate: NewsManagerDelegate?
    
    func fetchNews() {
        
        var newsArray = [NewsModel]()
        
        let urlString = "https://naspote.fun"
        if let url = URL(string: urlString) {
            
            
            do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                
                let div = try doc.select("div.w-grid-item-h").array()
                for i in div {
                    let html = try i.select("a[href]")
                    let htmlImg = try i.select("img")
                    
                    let title = try html.attr("aria-label")
                    let link = try  html.attr("href")
                    let image = try htmlImg.attr("src")
                    
                    newsArray.append(NewsModel(title: title, image: image, link: link))
                }
                
                
                
                let news = newsArray
                self.delegate?.didUpdateNews(news: news)
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}

