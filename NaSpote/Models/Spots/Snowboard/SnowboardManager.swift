//
//  SpotSnowManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import Foundation
import SwiftSoup

protocol SpotSnowManagerDelegate {
    func didUpdateNews(spot: SnowboardModel)
    func didFailWithError(error: Error)
}

struct SnowboardManager {
    
    var delegate: SpotSnowManagerDelegate?
    
    func fetchSpot() {
        
        var spotTitle = [String]()
        var spotMap = [String]()
        var spotLink = [String]()
        var img = [UIImage]()
        //    var spotPhone = [String]()
        
        let urlString = "https://naspote.fun/%d0%b3%d0%be%d1%80%d0%bd%d0%be%d0%bb%d1%8b%d0%b6%d0%ba%d0%b8/"
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
                        if !link3!.isEmpty && link3 != "Горнолыжки" {
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
                            let imageUrl = URL(string: link3!)
                            let imageData: Data
                            if imageUrl != nil {
                                imageData = try! Data(contentsOf: imageUrl!)
                                let image = UIImage(data: imageData)
                                img.append(image!)
                            } else {
                                let image = UIImage(named: "NotFound")
                                img.append(image!)
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
                            
//                print(spotImage)
                
                //            let spotPhoneNumber = try element?.select("a").array()
                //            for i in spotPhoneNumber! {
                //                let link = try i.text()
                //                print(link)
                //                spotPhone.append(link)
                //            }
                //            print(spotPhone)
                
                
                
                let spot = SnowboardModel(spotTitle: spotTitle, spotMap: spotMap, spotLink: spotLink, spotImg: img)
                self.delegate?.didUpdateNews(spot: spot)
                
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}

