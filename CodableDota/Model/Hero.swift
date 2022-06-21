//
//  Hero.swift
//  CodableDota
//
//  Created by Admin on 6/15/22.
//

import Foundation

struct Hero: Codable {
    let id:Int
    let name:String
    let primaryAttribute: String
    let attackType: String
    let legs: Int
    let image: String
    let roles: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "localized_name"
        case primaryAttribute = "primary_attr"
        case attackType = "attack_type"
        case legs = "legs"
        case image = "img"
        case roles
    }
}
