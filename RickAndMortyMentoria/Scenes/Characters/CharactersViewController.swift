//
//  CharactersViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 30/06/23.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionViewLayout()
        getAllCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    @IBAction func searchIconTapped(_ sender: Any) {
        let viewController = UIViewController();
        viewController.view.backgroundColor = .green
        viewController.title = "Navigation Test"
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "CharacterCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "characterCell")
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.collectionViewLayout = layout
    }
    
    func getAllCharacters() {
        let baseUrl = "https://rickandmortyapi.com/"
        let endpoint = "api/character"
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else { return }
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            if let _ = error { return }
            guard let data = data else { return }
            do {
                let characterInfo = try JSONDecoder().decode(CharacterInfo.self, from: data)
                self.characters = characterInfo.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        urlSession.resume()
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        let character = characters[indexPath.item]
        cell.delegate = self
        cell.configure(name: character.name, status: character.status, imageUrl: character.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 3 * 16) / 2
        return CGSize(width: cellWidth, height: 285)
    }
}

extension CharactersViewController: CharacterCollectionViewCellDelegate {
    func fetchImage(url: String, completion: @escaping ((Data?) -> Void)) {
        guard let url = URL(string: url) else { completion(nil); return }
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            if let _ = error { completion(nil); return }
            guard let data = data else { completion(nil); return }
            completion(data)
        }
        urlSession.resume()
    }
}
