//
//  House.swift
//  HarryPotter
//
//  Created by Jordan Bryant on 9/23/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

//struct TopLevelDictionary: Decodable {
//    let houses: [House]
//}

struct House: Decodable {
    let name: String
    let headOfHouse: String
    let founder: String
    let members: [String]
}
