//
//  DetailSpotManager.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.01.2022.
//

import Foundation
import SwiftSoup

protocol DetailSpotManagerDelegate {
    func didUpdateSpot(spot: [Contacts])
    func didFailWithError(error: Error)
}

struct DetailWakeboardManager {
    
    var delegate: DetailSpotManagerDelegate?
    
    func fetchSpot(_ url: String) {
        
        var detailSpotInfo = [String]()
        var detailSpotContacts = [String]()
        var spotGallery = [String]()
        
        var detailSpot = [Contacts]()
        
        if let url = URL(string: url) {
            
            do {
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(htmlString)
                
                let div = try doc.select("div.drts-bs-list-group").array()
                for i in div {
                    let html = try i.select("div.drts-bs-list-group-item")
                    let htmlPhone = try i.select("a")
                    
                    // MARK: Title
                    
                    let title = try doc.select("div.drts-display-element-entity_field_post_title-1").select("a").attr("title")
                    
                    // MARK: Location
                    
                    let location = try html.select("span.drts-location-address").text()
                    
                    // MARK: Phone
                    
                    let phone = try htmlPhone.attr("data-phone-number")
                    
                    // MARK: Raiting
                    
                    let htmlRaiting = try doc.select("div.drts-display-element-entity_field_voting_rating-1")
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
                    
                    // MARK: Networks
                    
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
                    
                    // MARK: Info
                    
                    let htmlInfo = try html.select("div.drts-bs-list-group-item").array()
                    
                    var weekday: Weekday {
                        var title = String()
                        var price = String()
                        do {
                            for i in htmlInfo {
                                if try i.text().contains("Цена за сет в будни") {
                                    title = try i.select("div.drts-entity-field-label").text()
                                    price = try i.select("div.drts-entity-field-value").text()
                                }
                            }
                        } catch let error {
                            print(error)
                        }
                        return Weekday(title: title, price: price)
                    }
                    
                    var weekend: Weekend {
                        var title = String()
                        var price = String()
                        do {
                            for i in htmlInfo {
                                if try i.text().contains("Цена за сет в выходные") {
                                    title = try i.select("div.drts-entity-field-label").text()
                                    price = try i.select("div.drts-entity-field-value").text()
                                }
                            }
                        } catch let error {
                            print(error)
                        }
                        return Weekend(title: title, price: price)
                    }
                    
                    var setDuration: SetDuration {
                        var title = String()
                        var duration = String()
                        do {
                            for i in htmlInfo {
                                if try i.text().contains("Длительность сета") {
                                    title = try i.select("div.drts-entity-field-label").text()
                                    duration = try i.select("div.drts-entity-field-value").text()
                                }
                            }
                        } catch let error {
                            print(error)
                        }
                        return SetDuration(title: title, duration: duration)
                    }
                    
                    var workingHours: WorkingHours {
                        var title = String()
                        var hours = String()
                        do {
                            for i in htmlInfo {
                                if try i.text().contains("Время работы") {
                                    title = try i.select("div.drts-entity-field-label").text()
                                    hours = try i.select("div.drts-entity-field-value").text()
                                }
                            }
                        } catch let error {
                            print(error)
                        }
                        return WorkingHours(title: title, hours: hours)
                    }
                    
                    // MARK: Services
                    
                    var services = [String]()
                    let htmlServices = try doc.select("div.drts-entity-field-value")
                    let servicesArray = try htmlServices.select("div.drts-bs-mb-1")
                    for i in servicesArray {
                        let service = try i.text()
                        services.append(service)
                    }
                    
                    // MARK: Gallery
                    var gallery = [String]()
                    let htmlGallery = try doc.select("div.drts-slider-photos-thumbnails")
                    let galleryArray = try htmlGallery.select("img").array()
                    for i in galleryArray {
                        let photo = try i.attr("src")
                        gallery.append(photo)
                    }
                    
                    detailSpot.append(Contacts(title: title, location: location, phone: phone, networks: networks, raiting: Raiting(average: average, count: count), weekday: weekday, weekend: weekend, setDuration: setDuration, workingHours: workingHours, services: services, gallery: gallery))
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
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
                
//                let detailSpot = DetailWakeboardModel(info: detailSpotInfo, contacts: detailSpotContacts, gallery: spotGallery)
                self.delegate?.didUpdateSpot(spot: detailSpot)
                
            } catch let error {
                print(error)
            }
        }
    }
}

