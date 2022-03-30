//
//  DetailCampManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 30.03.2022.
//

import Foundation
import SwiftSoup

protocol DetailCampManagerDelegate {
    func didUpdateDetailCamp(detailCamp: [DetailCampModel])
    func didFailWithError(error: Error)
}

struct DetailCampManager {
    
    var delegate: DetailCampManagerDelegate?
    
    func fetchDetailCamp(_ url: String) {
        
        var detailCamp = [DetailCampModel]()
        
        if let url = URL(string: url) {
            
            do {
                
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                let html = try doc.select("div.drts-entity-post")
                let htmlLogo = try html.select("img")
                let htmlPhone = try html.select("a")
                
                let title = try html.select("div.drts-display-element-entity_field_post_title-1").text()
                let date = try html.select("time").text()
                let logo = try htmlLogo.attr("src")
                let location = try html.select("span.drts-location-address").text()
                let phone = try htmlPhone.attr("data-phone-number")
                
                var networks: Networks {
                    var instagram = String()
                    var vk = String()
                    var website = String()
                    do {
                        let div = try html.select("div.drts-display-element-entity_field_field_website-1")
                        let htmlWebsite = try div.select("a")
                        website = try htmlWebsite.attr("href")
                        
                        let networks = try html.select("a.drts-social-media-account").array()
                        for i in networks {
                            let networks = try i.attr("title")
                            if networks == "Instagram" {
                                instagram = try i.attr("href")
                            }
                            if networks == "VKontakte" {
                                vk = try i.attr("href")
                            }
                        }
                    }
                    catch let error {
                        print(error)
                    }
                    return Networks(website: website, instagram: instagram, vk: vk)
                }
                
                var info = String()
                if let infoString = try html.select("p").first()?.text() {
                    info = infoString
                } else {
                    info = ""
                }
                
                
                detailCamp.append(DetailCampModel(title: title, date: date, logo: logo, location: location, phone: phone, networks: networks, info: info))
                
                self.delegate?.didUpdateDetailCamp(detailCamp: detailCamp)
            } catch let error {
                print(error)
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}

