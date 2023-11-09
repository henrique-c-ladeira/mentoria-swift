//
//  ImageLoader.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 19/10/23.
//

import Foundation

final class ImageLoader {
    static let shared = ImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() { }
    
    func fetchImage(url urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let key = urlString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else {
                completion(.failure(URLError(.fileDoesNotExist)))
                return
            }
            self.imageDataCache.setObject(data as NSData, forKey: key)
            completion(.success(data))
        }
        urlSession.resume()
    }
}
