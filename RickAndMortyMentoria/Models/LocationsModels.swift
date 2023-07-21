//
//  LocationsModel.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 21/07/23.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: [String]
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case dimension
        case residents
        case url
        case created
    }
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct LocationInfo: Codable {
    let info: Info
    let results: [Location]
}
