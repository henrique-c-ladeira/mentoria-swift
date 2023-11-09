//
//  CharacterDetailsViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 21/09/23.
//

import UIKit

protocol ImageLoaderDelegate: AnyObject {
    func fetchImage(url: String, completion: @escaping ((Data?) -> Void))
}

class CharacterDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var fourthStackView: UIStackView!
    
    public var model: Character?
    weak var delegate: ImageLoaderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = model else { return }
        configure(with: model)
        configureImage()
    }
    
    private func configureImage() {
        guard let model = model else { return }
        delegate?.fetchImage(url: model.image, completion: { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        })
    }
    
    private func configure(with model: Character) {
        configureFirstStack(with: model)
        configureSecondStack(with: model)
        configureThirdStack(with: model)
        configureFourthStack(with: model)
        view.layoutIfNeeded()
    }
    
    private func configureFirstStack(with model: Character) {
        let view1 = createSubView(value: model.status, type: "status".uppercased())
        let view2 = createSubView(value: model.gender, type: "gender".uppercased())
        firstStackView.addArrangedSubview(view1)
        firstStackView.addArrangedSubview(view2)
    }
    
    private func configureSecondStack(with model: Character) {
        let view1 = createSubView(value: model.type ?? "None", type: "type".uppercased())
        let view2 = createSubView(value: model.species, type: "species".uppercased())
        secondStackView.addArrangedSubview(view1)
        secondStackView.addArrangedSubview(view2)
    }
    
    private func configureThirdStack(with model: Character) {
        let view1 = createSubView(value: model.origin.name, type: "origin".uppercased())
        let view2 = createSubView(value: model.location.name, type: "location".uppercased())
        thirdStackView.addArrangedSubview(view1)
        thirdStackView.addArrangedSubview(view2)
    }
    
    private func configureFourthStack(with model: Character) {
        let view1 = createSubView(value: model.created, type: "created".uppercased())
        let view2 = createSubView(value: "\(model.episode.count)", type: "Episode Count".uppercased())
        fourthStackView.addArrangedSubview(view1)
        fourthStackView.addArrangedSubview(view2)
    }

    private func createSubView(value: String, type: String) -> CharacterDetailView {
        let view = CharacterDetailView()
        view.configure(value: value, type: type)
        return view
    }
}
