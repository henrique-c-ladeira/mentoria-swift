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
    var imageLoader: ImageLoader { .shared }
    var service = RickAndMortyService(httpClient: URLSession.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionViewLayout()
        getAllCharacters()
    }
    
    @IBAction func searchIconTapped(_ sender: Any) {
        let searchViewController = SearchViewController(type: title, searchType: .characters)
        navigationController?.pushViewController(searchViewController, animated: true)
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
        let item = QueryBuilder()
            .getResult()
        service.filterCharacters(queryItems: item) { result in
            switch result {
            case .success(let characterInfo):
                self.characters = characterInfo.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
//        service.getAllCharacters { result in
//            switch result {
//            case .success(let characterInfo):
//                self.characters = characterInfo.results
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//
//        }
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ImageLoaderDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        let characterStoryboard = UIStoryboard(name: "Characters", bundle: nil)
        let characterVC = characterStoryboard.instantiateViewController(withIdentifier: "CharacterDetailVC") as! CharacterDetailsViewController
        characterVC.model = character
        characterVC.delegate = self
        navigationController?.pushViewController(characterVC, animated: true)
    }
    
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
        imageLoader.fetchImage(url: url) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(_):
                completion(nil)
            }
            
        }
    }
}
