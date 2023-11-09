//
//  CharactersModels.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 17/08/23.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: UrlInfo
    let location: UrlInfo
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterInfo: Codable {
    let info: Info
    let results: [Character]
}

struct UrlInfo: Codable {
    let name: String
    let url: String
}

