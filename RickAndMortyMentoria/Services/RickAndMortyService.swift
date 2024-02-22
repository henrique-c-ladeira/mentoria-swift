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
    
    // MARK: - Character
    func getSingleCharacter(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        let provider = CharacterProvider.getSingleCharacter(id: id)
        let request = provider.makeRequest
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
    
    func getAllCharacters(completion: @escaping (Result<CharacterInfo, Error>) -> Void) {
        let provider = CharacterProvider.getAllCharacters
        let request = provider.makeRequest
        httpClient.perform(request: request) { result in
            switch result {
            case .success(let (data, _)):
                do {
                    let decoded: CharacterInfo = try JSONDecoder().decode(CharacterInfo.self, from: data)
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterCharacters(queryItems: [URLQueryItem], completion: @escaping (Result<CharacterInfo, Error>) -> Void) {
        let provider = CharacterProvider.filterCharacters(queryItems: queryItems)
        let request = provider.makeRequest
        httpClient.perform(request: request) { result in
            switch result {
            case .success(let (data, _)):
                do {
                    let decoded: CharacterInfo = try JSONDecoder().decode(CharacterInfo.self, from: data)
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterLocation(queryItems: [URLQueryItem], completion: @escaping (Result<LocationInfo, Error>) -> Void) {
        let provider = LocationProvider.filterLocation(queryItems: queryItems)
        let request = provider.makeRequest
        httpClient.perform(request: request) { result in
            switch result {
            case .success(let (data, _)):
                do {
                    let decoded: LocationInfo = try JSONDecoder().decode(LocationInfo.self, from: data)
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterEpisodes(queryItems: [URLQueryItem], completion: @escaping (Result<EpisodesInfo, Error>) -> Void) {
        let provider = EpisodesProvider.filterEpisodes(queryItems: queryItems)
        let request = provider.makeRequest
        httpClient.perform(request: request) { result in
            switch result {
            case .success(let (data, _)):
                do {
                    let decoded: EpisodesInfo = try JSONDecoder().decode(EpisodesInfo.self, from: data)
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Location
    func getAllLocations(completion: @escaping (Result<LocationInfo, Error>) -> Void) {
        let provider = LocationProvider.getAllLocations
        let request = provider.makeRequest
        httpClient.perform(request: request) { result in
            switch result {
            case .success(let (data, _)):
                do {
                    let decoded: LocationInfo = try JSONDecoder().decode(LocationInfo.self, from: data)
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Episodes
    func getAllEpisodes(completion: @escaping (Result<EpisodesInfo, Error>) -> Void) {
        let provider = EpisodesProvider.getAllEpisodes
        let request = provider.makeRequest
        httpClient.perform(request: request) { result in
            switch result {
            case .success(let (data, _)):
                do {
                    let decoded: EpisodesInfo = try JSONDecoder().decode(EpisodesInfo.self, from: data)
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
