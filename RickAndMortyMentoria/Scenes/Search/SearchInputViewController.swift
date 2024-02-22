//
//  SearchInputViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 11/01/24.
//

import UIKit

protocol SearchInputViewControllerDelegate: AnyObject {
    func didChooseInput(tag: Int, param: QueryArgument, value: String)
}

class SearchInputViewController: UIViewController {
    
    var tag: Int
    var queryArgument: QueryArgument
    var dataSource: [String] = []
    weak var delegate: SearchInputViewControllerDelegate?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.delegate = self
        tv.dataSource = self
        tv.alwaysBounceVertical = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv;
    }()
    
    init(tag: Int, queryArgument: QueryArgument) {
        self.tag = tag
        self.queryArgument = queryArgument
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.reloadData()
    }
    
    private func configureDataSource() {
        switch queryArgument {
        case .status:
            dataSource = QueryArgument.Status.allCases.map { $0.rawValue }
        case .type:
            dataSource = QueryArgument.LocationType.allCases.map { $0.rawValue }
        case .gender:
            dataSource = QueryArgument.Gender.allCases.map { $0.rawValue }
        default:
            dataSource = []
        }
    }

}

extension SearchInputViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].capitalized
        return cell
    }
    
}

extension SearchInputViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didChooseInput(tag: tag, param: queryArgument, value: dataSource[indexPath.row])
    }
}
