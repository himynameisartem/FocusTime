//
//  NewsManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 21.11.2021.
//

import Foundation
import SwiftSoup

protocol NewsManagerDelegate {
    func didUpdateNews(news: NewsModel)
    func didFailWithError(error: Error)
}

struct NewsManager {
    
    var delegate: NewsManagerDelegate?
    
    func fetchNews() {
        
        var newsImage = [String]()
        var newsString = [String]()
        var newsLink = [String]()
        
        let urlString = "https://naspote.fun"
        if let url = URL(string: urlString) {
            
            
            do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                let element = try doc.select("main").first()
                
                let newsStr = try element?.select("a").array()
                var newsCount = 0
                for _ in newsStr! {
                    if !newsStr!.isEmpty  {
                        let link = try newsStr?[newsCount].attr("aria-label")
                        newsCount += 1
                        if !link!.isEmpty {
                            newsString.append(link!)
                        }
                    }
                }
                
                let newsImg = try element?.select("img").array()
                var imageCount = 0
                for _ in newsImg! {
                    if !newsImg!.isEmpty  {
                        let link3 = try newsImg?[imageCount].attr("src")
                        imageCount += 1
                        if !link3!.isEmpty {
                            newsImage.append(link3!)
                        }
                    }
                }
                
                let newslnk = try element?.select("h2").array()
                for i in newslnk! {
                    let a = try i.select("a").array()
                    let href = try a[0].attr("href")
                    newsLink.append(href)
                }
                
                let news = NewsModel(newsString: newsString, newsImage: newsImage, newsLink: newsLink)
                self.delegate?.didUpdateNews(news: news)
                
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}

