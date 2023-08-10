//
//  ViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 21/07/23.
//

import UIKit

class LocationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var locations: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getAllLocations()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getAllLocations() {
        let baseURL = "https://rickandmortyapi.com/api/"
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
                print("Error: \(error)")
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let locationInfo = try JSONDecoder().decode(LocationInfo.self, from: data)
                self.locations = locationInfo.results;
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }
        
        session.resume();
        
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
    }
    

}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        cell.configureCell(name: locations[indexPath.row].name, type: locations[indexPath.row].type, dimension: locations[indexPath.row].dimension)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath) \(tableView)")
    }
}
