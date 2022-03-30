//
//  DetailSpotModel.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.01.2022.
//

import Foundation

struct DetailWakeboardModel {
    let info: [String]
    let contacts: [String]
    let gallery: [String]
}


struct Contacts {
    let location: String
    let phone: String
    let networks: Networks
    let raiting: Raiting
    let weekday: Weekday
    let weekend: Weekend
    let setDuration: SetDuration
    let workingHours: WorkingHours
    let services: [String]
    let gallery: [String]
}

struct Networks {
    let website: String
    let instagram: String
    let vk: String
}

struct Weekday {
    let title: String
    let price: String
}

struct Weekend {
    let title: String
    let price: String
}

struct SetDuration {
    let title: String
    let duration: String
}

struct WorkingHours {
    let title: String
    let hours: String
}

