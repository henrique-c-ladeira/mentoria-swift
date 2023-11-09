//
//  APIEndpoint.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 09/11/23.
//

import Foundation

protocol ApiEndpoint {
    var baseURLString: String { get }
    var apiPath: String { get }
    var separatorPath: String? { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var queryForCall: [URLQueryItem]? { get }
    var params: [String: Any]? { get }
    var method: APIHTTPMethod { get }
    var customDataBody: Data? { get }
}

extension ApiEndpoint {
    var makeRequest: URLRequest {
        var urlComponents = URLComponents(string: baseURLString)
        var longPath = "/"
        longPath.append(apiPath)
        if let separatorPath = separatorPath {
            longPath.append("/")
            longPath.append(separatorPath)
        }
        longPath.append("/")
        longPath.append(path)
        urlComponents?.path = longPath
        
        if let queryForCalls = queryForCall {
            urlComponents?.queryItems = [URLQueryItem]()
            for queryForCall in queryForCalls {
                urlComponents?.queryItems?.append(URLQueryItem(name: queryForCall.name, value: queryForCall.value))
            }
        }
        
        guard let url = urlComponents?.url else {
            return URLRequest(url: URL(string: baseURLString)!)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
 
        if let params = params {
            let jsonData = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = jsonData
        }
 
        if let customDataBody = customDataBody {
            request.httpBody = customDataBody
        }
 
        return request
    }
}
