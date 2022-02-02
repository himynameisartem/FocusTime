//
//  DetailSpotManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.01.2022.
//

import Foundation
import SwiftSoup

protocol DetailSpotManagerDelegate {
    func didUpdateSpot(spot: DetailWakeboardModel)
    func didFailWithError(error: Error)
}

struct DetailWakeboardManager {
    
    var delegate: DetailSpotManagerDelegate?
//
    func fetchSpot(_ url: String) {
//
    var detailSpotInfo = [String]()
    var detailSpotContacts = [String]()
    var spotGallery = [String]()
//    var spotPhone = [String]()

        
        if let url = URL(string: url) {

        
       
        do {
            let htmlString = try String(contentsOf: url, encoding: .utf8)
            let doc = try SwiftSoup.parse(htmlString)
            let element = try doc.select("div.drts-row")[1]

            let spotTtl = try element.select("div").array()
            for i in spotTtl {
                let txt = try i.text()
                if !detailSpotInfo.contains(txt) {
                detailSpotInfo.append(txt)
                }
            }
            
            let element2 = try doc.select("div.drts-bs-list-group")[0]
            
            let spotContacts = try element2.select("div.drts-entity-field").array()
            for i in spotContacts {
                let txt = try i.text()
                if !detailSpotContacts.contains(txt) && txt != "Соц. сети" {
                    detailSpotContacts.append(txt)
                }
            }
            
            let element3 = try doc.select("div.drts-slider-photos-main")[0]

            let gallery = try element3.select("img").array()
            for i in gallery {
                let txt = try i.attr("src")
                if !spotGallery.contains(txt) {
                    spotGallery.append(txt)
                }
            }
            
            
            detailSpotInfo.removeFirst()
            detailSpotContacts.removeFirst()
            
            let detailSpot = DetailWakeboardModel(info: detailSpotInfo, contacts: detailSpotContacts, gallery: spotGallery)
            self.delegate?.didUpdateSpot(spot: detailSpot)

        } catch let error {
            print(error)
        }
    }
    }
}

