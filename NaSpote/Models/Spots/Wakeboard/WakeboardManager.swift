//
//  SpotManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import Foundation
import SwiftSoup

protocol SpotManagerDelegate {
    func didUpdateNews(spot: WakeboardModel)
    func didFailWithError(error: Error)
}

struct WakeboardManager {
    
    var delegate: SpotManagerDelegate?
    
    func fetchSpot() {
        
        var spotImage = [String]()
        var spotTitle = [String]()
        var spotMap = [String]()
        var spotLink = [String]()
//        var spotPhone = [String]()
        
        let urlString = "https://naspote.fun/%d0%b2%d0%b5%d0%b9%d0%ba%d0%b1%d0%be%d1%80%d0%b4/"
        if let url = URL(string: urlString) {
            
            do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                let element = try doc.select("main").first()
                
                
                let spotTtl = try element?.select("a").array()
                var newsCount = 0
                for _ in spotTtl! {
                    if !spotTtl!.isEmpty  {
                        let link3 = try spotTtl?[newsCount].attr("title")
                        newsCount += 1
                        if !link3!.isEmpty && link3 != "Кабельный вейкборд" {
                            spotTitle.append(link3!)
                        }
                    }
                }
                
                
                
                let spotImg = try element?.select("img").array()
                var imageCount = 0
                for _ in spotImg! {
                    if !spotImg!.isEmpty  {
                        let link3 = try spotImg?[imageCount].attr("src")
                        imageCount += 1
                        if !link3!.isEmpty {
                            spotImage.append(link3!)
                        }
                    }
                }
                
                let element2 = try doc.select("div")[134]
                let map = try element2.select("span").array()
                for i in map {
                    
                    let a = try i.attr("class", "data-key=")
                    let b = try a.text()
                    if b != "Открыто" {
                        spotMap.append(b)
                    }
                }
                
                let link = try element?.select("a")
                for i in link! {
                    let linkToSpot = try i.attr("href")
                    let searchStr = "listing"
                    if linkToSpot.contains(searchStr) {
                        if !spotLink.contains(linkToSpot) {
                            spotLink.append(linkToSpot)
                        }
                    }
                }
                
//                let spotPhoneNumber = try element?.select("a").array()
//                for i in spotPhoneNumber! {
//                    let phoneToSpot = try i.attr("href")
//                    if phoneToSpot.contains("tel") {
//                        print(phoneToSpot)
//                    }
//                    print(phoneToSpot)
//                    let link = try i.text()
//                    print(link)
//                    spotPhone.append(phoneToSpot)
//                }
//                print(spotPhone)
                
                
                
                let spot = WakeboardModel(spotImage: spotImage, spotTitle: spotTitle, spotMap: spotMap, spotLink: spotLink)
                self.delegate?.didUpdateNews(spot: spot)
                
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}

