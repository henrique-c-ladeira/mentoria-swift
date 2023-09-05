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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func getAllEpisodes() {
        let baseUrl = "https://rickandmortyapi.com/api/"
        let endpoint = "episode"
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else { return }
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error { print(error); return }
            guard let data = data else { return }
            do {
                let episodesInfo = try JSONDecoder().decode(EpisodesInfo.self, from: data)
                self.episodes = episodesInfo.results;
                print(self.episodes)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
                return
            }
        }
        urlSession.resume()
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

