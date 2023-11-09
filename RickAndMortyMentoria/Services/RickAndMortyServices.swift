//
//  RickAndMortyServices.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 09/11/23.
//

import Foundation

class RickAndMortyService: GenericHTTPService {
    var httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getSingleCharacter(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        let request = URLRequest(url: <#T##URL#>)
        httpClient.perform(request: request) { result in
            switch result {
            case .success(let (data, _)):
                do {
                    let decoded: Character = try JSONDecoder().decode(Character.self, from: data)
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
