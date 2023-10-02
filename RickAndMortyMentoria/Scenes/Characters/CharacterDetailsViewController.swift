//
//  CharacterDetailsViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 21/09/23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    @IBOutlet weak var firstStackView: UIStackView!
    
    @IBOutlet weak var secondStackView: UIStackView!
    
    @IBOutlet weak var thirdStackView: UIStackView!
    
    @IBOutlet weak var fourthStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(with model: Character) {
        configureFirstStack(with: model)
    }
    
    func configureFirstStack(with model: Character) {
        let view1 = createSubView(value: model.status, type: "status".uppercased())
        let view2 = createSubView(value: model.status, type: "gender".uppercased())
        firstStackView.addArrangedSubview(view1)
        firstStackView.addArrangedSubview(view2)
    }

    func createSubView(value: String, type: String) -> CharacterDetailView {
        let view = CharacterDetailView.init(frame: .zero)
        view.configure(value: value, type: type)
        return view
    }
}
