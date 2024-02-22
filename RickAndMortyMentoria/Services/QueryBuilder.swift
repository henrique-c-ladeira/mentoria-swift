//
//  QueryBuilder.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 30/11/23.
//

import Foundation

enum QueryArgument: String {
    
    case name
    case status
    case species
    case type
    case gender
    
    enum Status: String, CaseIterable {
        case alive
        case dead
        case unknown
    }
    
    enum Gender: String, CaseIterable {
        case female
        case male
        case genderless
        case unknown
    }
    
    enum LocationType: String, CaseIterable {
        case cluster
        case planet
        case microverse
    }
}

class QueryBuilder {
    var items = [URLQueryItem]()
    
    func addFilter(param: QueryArgument, value: String) -> Self {
        let queryItem = URLQueryItem(name: param.rawValue, value: value)
        items.append(queryItem)
        return self
    }
    
    
    func addFilter(_ value: QueryArgument.Status) -> Self {
        let queryItem = URLQueryItem(name: QueryArgument.status.rawValue, value: value.rawValue)
        items.append(queryItem)
        return self
    }
    
    func addFilter(_ value: QueryArgument.Gender) -> Self {
        let queryItem = URLQueryItem(name: QueryArgument.status.rawValue, value: value.rawValue)
        items.append(queryItem)
        return self
    }
    
    func getResult() -> [URLQueryItem] {
        items
    }
}
