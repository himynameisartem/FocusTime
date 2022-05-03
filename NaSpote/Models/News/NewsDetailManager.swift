//
//  DetailNewsManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 04.12.2021.
//

import Foundation
import SwiftSoup

protocol DetailNewsManagerDelegate {
    func didUpdateNews(teams: NewsDetailModel)
    func didFailWithError(error: Error)
}

struct NewsDetailManager {
    
    var delegate: DetailNewsManagerDelegate?
    
    func fetchNews(_ url: String) {
        
        var newsString = String()
        
        let urlString = url
        if let url = URL(string: urlString) {
            
            do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let htmlContent = htmlString
                let doc = try SwiftSoup.parse(htmlContent)
                let element = try doc.select("main").first()
                
                let newslnk = try element?.select("p").array()
                for i in newslnk! {
                    let a = try i.text()
                    newsString.append("     \(a) \n \n")
                }
                
                let news = NewsDetailModel(textNews: newsString)
                self.delegate?.didUpdateNews(teams: news)
                
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}
