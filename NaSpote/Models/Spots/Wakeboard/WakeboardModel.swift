//
//  SpotData.swift
//  NaSpote
//
//  Created by Артем Кудрявцев on 05.12.2021.
//

import Foundation

struct WakeboardModelTest {
    let image: String
    let title: String
    let type: String
    let phone: String
    let location: String
    let link: String
    let raiting: Raiting
}

struct Raiting {
    let average: Double
    let count : Int
}
