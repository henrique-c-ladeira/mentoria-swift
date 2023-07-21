//
//  ViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 21/07/23.
//

import UIKit

class LocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllLocations()
    }
    
    private func getAllLocations() {
        let baseURL = "https://rickandmortyapi/com/api/"
        let endpoint = "location"
        let urlString = "\(baseURL)\(endpoint)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("ErrorL \(error)")
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let locationInfo = try JSONDecoder().decode(LocationInfo.self, from: data)
                print(locationInfo)
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }
        
        session.resume();
        
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
    }
    

}
