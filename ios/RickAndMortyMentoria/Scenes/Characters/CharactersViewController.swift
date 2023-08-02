//
//  CharactersViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 30/06/23.
//

import UIKit

class CharactersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchIconTapped(_ sender: Any) {
        let viewController = UIViewController();
        viewController.view.backgroundColor = .green
        viewController.title = "Navigation Test"
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
