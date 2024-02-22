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

struct TableViewDataSource {
    let title: String
    let description: String
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var queryStackView: UIStackView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var noResultsImageView: UIImageView!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var type: String
    var searchType: SearchType
    var queryArguments: [QueryArgument] = []
    var dataSource = [TableViewDataSource]() // result is same as `var dataSource: [TableViewDataSource] = []`
    var builder = QueryBuilder()
    var service = RickAndMortyService(httpClient: URLSession.shared)
    
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
        configureTableView()
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
    
    private func configureTableView() {
        searchResultTableView.dataSource = self
        searchResultTableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "searchResultTableViewCell")
    }
    
    private func configureNoResultsView() {
        let image = UIImage(systemName: "magnifyingglass.circle")
        noResultsImageView.image = image
        noResultsImageView.tintColor = .green
        
        noResultsLabel.text = "No Results"
        noResultsLabel.textAlignment = .center
        noResultsLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        noResultsView.isHidden = true
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
        let vc = SearchInputViewController(tag: sender.tag, queryArgument: queryArguments[sender.tag])
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    private func filterCharacters() {
        service.filterCharacters(queryItems: builder.getResult()) { result in
            switch result {
            case .success(let info):
                info.results.forEach { character in
                    let dataSource = TableViewDataSource(title: character.name,
                                                         description: "Species: \(character.species)")
                    self.dataSource.append(dataSource)
                }
                DispatchQueue.main.async {
                    self.searchResultTableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.noResultsView.isHidden = false
                }
            }
        }
    }
    
    private func filterEpisodes() {
        service.filterEpisodes(queryItems: builder.getResult()) { result in
            switch result {
            case .success(let info):
                info.results.forEach { episode in
                    let dataSource = TableViewDataSource(title: episode.name,
                                                         description: "Air Date: \(episode.air_date)")
                    self.dataSource.append(dataSource)
                }
                DispatchQueue.main.async {
                    self.searchResultTableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.noResultsView.isHidden = false
                }
            }
        }
    }
    
    private func filterLocation() {
        service.filterLocation(queryItems: builder.getResult()) { result in
            switch result {
            case .success(let info):
                info.results.forEach { location in
                    let dataSource = TableViewDataSource(title: location.name,
                                                         description: "Dimension: \(location.dimension)")
                    self.dataSource.append(dataSource)
                }
                DispatchQueue.main.async {
                    self.searchResultTableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.noResultsView.isHidden = false
                }
            }
        }
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        searchBar.resignFirstResponder()
        dataSource.removeAll()
        noResultsView.isHidden = true
        
        builder = builder.addFilter(param: QueryArgument.name, value: searchBar.text ?? "")
        
        switch searchType {
        case .characters:
            filterCharacters()
        case .episode:
            filterEpisodes()
        case .location:
            filterLocation()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "") {
            noResultsView.isHidden = true
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultTableViewCell", for: indexPath) as? SubtitleTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = dataSource[indexPath.row].title
        cell.detailTextLabel?.text = dataSource[indexPath.row].description
        return cell
    }
}

extension SearchViewController: SearchInputViewControllerDelegate {
    func didChooseInput(tag: Int, param: QueryArgument, value: String) {
        dismiss(animated: true)
        
        guard let button = queryStackView.subviews.first(where: { $0.tag == tag }) as? UIButton else { return }
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .medium) , .foregroundColor: UIColor.systemBlue]
        let attributedTitle = NSAttributedString(string: value.capitalized, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        builder = builder.addFilter(param: param, value: value)
        
    }
}

class SubtitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
