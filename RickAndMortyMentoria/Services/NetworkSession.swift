//
//  NetworkSession.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 09/11/23.
//

import Foundation

protocol HTTPClient {
    func perform(request: URLRequest,
                 completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

protocol GenericHTTPService {
    var httpClient: HTTPClient { get }
}

extension URLSession: HTTPClient {
    struct InvalidHTTPResponseError: Error { }
    
    func perform(request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        let task = dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(InvalidHTTPResponseError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(InvalidHTTPResponseError()))
                return
            }
            
            let tupleResponse = (data, httpResponse)
            completion(.success(tupleResponse))
        }
        task.resume()
    }
}
