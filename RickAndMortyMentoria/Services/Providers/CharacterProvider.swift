//
//  CharacterProvider.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 09/11/23.
//

import Foundation

enum CharacterProvider {
    case getAllCharacters
    case getSingleCharacter(id: Int)
    case getMultipleCharacter(ids: [Int])
    case filterCharacters(queryItems: [URL])
}

extension CharacterProvider: ApiEndpoint {
    var baseURLString: String {
        "https://rickandmortyapi.com"
    }
    
    var apiPath: String {
        "api"
    }
    
    var separatorPath: String? {
        "character"
    }
    
    var path: String {
        switch self {
        case .getAllCharacters: return ""
        case .getSingleCharacter(let id): return "\(id)"
        case .getMultipleCharacter(let ids): return "\(ids.map { "\($0)" }.joined(separator: ",").dropLast())"
        case .filterCharacters: return ""
        }
    }
    
    var headers: [String : String]? {
        <#code#>
    }
    
    var queryForCall: [URLQueryItem]? {
        <#code#>
    }
    
    var params: [String : Any]? {
        <#code#>
    }
    
    var method: APIHTTPMethod {
        <#code#>
    }
    
    var customDataBody: Data? {
        <#code#>
    }
    
    
}
