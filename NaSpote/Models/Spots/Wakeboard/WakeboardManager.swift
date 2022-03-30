//
//  SpotManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import Foundation
import SwiftSoup

protocol SpotManagerDelegate {
    func didUpdateNews(spot: [WakeboardModelTest])
    func didFailWithError(error: Error)
}

struct WakeboardManager {
    
    var delegate: SpotManagerDelegate?
    
    func fetchSpot() {
        
        var spot = [WakeboardModelTest]()
        
        let urlString = "https://naspote.fun/%d0%b2%d0%b5%d0%b9%d0%ba%d0%b1%d0%be%d1%80%d0%b4/"
        if let url = URL(string: urlString) {
            
            do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                let div = try doc.select("div.drts-gutter-none").array()
                
                for i in div {
                    
                    let htmlImage = try i.select("img")
                    let htmlTitle = try i.select("a[href]")
                    let htmlType = try i.select("a[href]")[2]
                    let htmlPhone = try i.select("a")
                    let htmlRaiting = try i.select("div.drts-display-element-entity_field_voting_rating-1")
                    
                    let image = try htmlImage.attr("src")
                    let title = try htmlTitle.attr("title")
                    let type = try htmlType.attr("title")
                    let phone = try htmlPhone.attr("data-phone-number")
                    let location = try i.select("span.drts-location-address").text()
                    let link = try  htmlTitle.attr("href")
                    let raitingAverage = Double(try htmlRaiting.select("span.drts-voting-rating-average").text())
                    let raitingCount = Int(try htmlRaiting.select("span.drts-voting-rating-count").text())
                    
                    var average: Double
                    var count: Int
                    if raitingAverage != nil, raitingCount != nil {
                        average = raitingAverage!
                        count = raitingCount!
                    } else {
                        average = 0.0
                        count = 0
                    }
                    
                    let test = WakeboardModelTest(image: image, title: title, type: type, phone: phone, location: location, link: link, raiting: Raiting(average: average, count: count))
                    spot.append(test)
                }
                
                self.delegate?.didUpdateNews(spot: spot)
                
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}

