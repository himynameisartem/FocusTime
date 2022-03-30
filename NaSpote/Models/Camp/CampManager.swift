//
//  Camp Manager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 29.03.2022.
//

import Foundation
import SwiftSoup

protocol CampManagerDelegate {
    func didUpdateCamp(camp: [CampModel])
    func didFailWithError(error: Error)
}


struct CampManager {
    
    var delegate: CampManagerDelegate?
    
    func fetchCamp() {
        
        var camp = [CampModel]()
        
        let urlString = "https://naspote.fun/%d0%ba%d0%b5%d0%bc%d0%bf%d1%8b/"
        if let url = URL(string: urlString) {
            
            do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                
                let div = try doc.select("div.drts-display-element-columns-1").array()
                for i in div {
                    let htmlTitle = try i.select("a")
                    let htmlType = try i.select("div.drts-display-element-entity_field_directory_category-1")
                    let typeTitle = try htmlType.select("a")
                    let htmlLogo = try i.select("div.drts-display-element-entity_field_directory_photos-1")
                    
                    let title = try htmlTitle.attr("title")
                    let link = try htmlTitle.attr("href")
                    let date = try i.select("time").text()
                    let type = try typeTitle.attr("title")
                    let location = try i.select("span.drts-location-address").text()
                    let logo = try htmlLogo.attr("style").replacingOccurrences(of: "background-image:url(", with: "").replacingOccurrences(of: ");", with: "")
                    
                    camp.append(CampModel(title: title, link: link, date: date, type: type, location: location, logo: logo))
                }
                
                self.delegate?.didUpdateCamp(camp: camp)
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}
