//
//  ViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 21/07/23.
//

import UIKit

class LocationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "row: \(indexPath.row)"
        cell.detailTextLabel?.text = "row: \(indexPath.section)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath) \(tableView)")
    }
}
