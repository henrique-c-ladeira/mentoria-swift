//
//  SearchViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 14/12/23.
//

import UIKit

enum SearchType {
    case characters
    case episode
    case location
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var queryStackView: UIStackView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var noResultsImageView: UIImageView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    var type: String
    var searchType: SearchType
    var queryArguments: [QueryArgument] = []
    
    init(type: String?, searchType: SearchType) {
        self.type = type ?? ""
        self.searchType = searchType
        super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureSearchBar()
        configureNoResultsView()
        configureQueryArguments()
        configureQueryStackView()
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
    
    private func configureNoResultsView() {
        let image = UIImage(systemName: "magnifyingglass.circle")
        noResultsImageView.image = image
        noResultsImageView.tintColor = .green
        
        noResultsLabel.text = "No Results"
        noResultsLabel.textAlignment = .center
        noResultsLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    private func configureQueryArguments() {
        switch searchType {
        case .characters:
            queryArguments = [.status, .gender]
        case .location:
            queryArguments = [.type]
        default:
            break
        }
    }
    
    private func configureQueryStackView() {
        queryArguments.enumerated().forEach { index, queryArgument in
            let button = createButton(title: queryArgument.rawValue.capitalized, tag: index)
            queryStackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(title: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .secondarySystemFill
        button.layer.cornerRadius = 6
        button.tag = tag
        
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .medium) , .foregroundColor: UIColor.label]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let vc = UIViewController()
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
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
