//
//  EpisodesViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 17/08/23.
//

import UIKit

class EpisodesViewController:    UIViewController {
                                    
    @IBOutlet weak var tableView: UITableView!
    var episodes: [Episode] = []
    let service = RickAndMortyService(httpClient: URLSession.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getAllEpisodes()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "EpisodeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "episodeCell")
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        let searchViewController = SearchViewController(type: title, searchType: .episode)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func getAllEpisodes() {
        service.getAllEpisodes { result in
            switch result {
            case .success(let episodesInfo):
                self.episodes = episodesInfo.results;
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episodeViewCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeTableViewCell else { return UITableViewCell() }
        episodeViewCell.configureCell(airedDate: episodes[indexPath.row].air_date, name: episodes[indexPath.row].name, episodeNumber: episodes[indexPath.row].episode)
        return episodeViewCell
    }
    
    
    
}

