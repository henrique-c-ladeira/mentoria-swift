//
//  SearchViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 14/12/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var type: String
    
    init(type: String?) {
        self.type = type ?? ""
        super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchBar.becomeFirstResponder()
    }
    
    private func configureNavigation() {
        title = "Search \(type)"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchTapped))
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "Name"
        searchBar.delegate = self
    }

    @IBAction func searchTapped(_ sender: Any) {
        print("Tapped")
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
