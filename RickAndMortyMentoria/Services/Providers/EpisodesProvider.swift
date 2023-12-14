//
//  EpisodesProvider.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 23/11/23.
//

import Foundation

enum EpisodesProvider {
    case getAllEpisodes
    case getSingleEpisode(id: Int)
    case filterEpisodes(queryItems: [URLQueryItem])
}


extension EpisodesProvider: ApiEndpoint {
    var baseURLString: String {
        "https://rickandmortyapi.com"
    }
    
    var apiPath: String {
        "api"
    }
    
    var separatorPath: String? {
        "episode"
    }
    
    var path: String {
        switch self {
        case .getSingleEpisode(let id): return "\(id)"
        default: return ""
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var queryForCall: [URLQueryItem]? {
        switch self {
        case .filterEpisodes(let queryItems): return queryItems
        default: return nil
        }
    }
    
    var params: [String : Any]? {
        nil
    }
    
    var method: APIHTTPMethod {
        .GET
    }
    
    var customDataBody: Data? {
        nil
    }
    
    
}
