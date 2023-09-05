//
//  EpisodesModels.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 17/08/23.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

struct EpisodesInfo: Decodable {
    let info: Info
    let results: [Episode]
}
