//
//  LocationProvider.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 23/11/23.
//

import Foundation

enum LocationProvider {
    case getAllLocations
    case getSingleLocation(id: Int)
    case filterLocation(queryItems: [URLQueryItem])
}

extension LocationProvider: ApiEndpoint {
    var baseURLString: String {
        "https://rickandmortyapi.com"
    }
    
    var apiPath: String {
        "api"
    }
    
    var separatorPath: String? {
        "location"
    }
    
    var path: String {
        switch self {
        case .getSingleLocation(let id): return "\(id)"
        default: return ""
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var queryForCall: [URLQueryItem]? {
        switch self {
        case .filterLocation(let queryItems): return queryItems
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
