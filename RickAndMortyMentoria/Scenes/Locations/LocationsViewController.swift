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
    
    let service = RickAndMortyService(httpClient: URLSession.shared)
    
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
        service.getAllLocations { result in
            switch result {
            case .success(let locationsInfo):
                self.locations = locationsInfo.results;
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let searchViewController = SearchViewController(type: title, searchType: .location)
        navigationController?.pushViewController(searchViewController, animated: true)
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
