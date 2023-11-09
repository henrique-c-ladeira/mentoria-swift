//
//  CharacterDetailView.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 02/10/23.
//

import UIKit

class CharacterDetailView: XibView {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func commonXibInit() {
        configureTypeView()
        configureTypeLabel()
        configureImageLabel()
    }
    func configure(value: String, type: String) {
        valueLabel.text = value
        typeLabel.text = type
    }
    
    func configureTypeView() {
        typeView.backgroundColor = .lightGray
        typeView.layer.borderColor = UIColor.gray.cgColor
        typeView.layer.cornerRadius = 8
        typeView.layer.masksToBounds = true
        typeView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func configureTypeLabel() {
        let color = UIColor.random()
        typeLabel.font = UIFont.systemFont(ofSize: 1, weight: .semibold)
        typeLabel.textColor = color
    }
    
    func configureImageLabel() {
        let color = UIColor.random()
        imageView.image = UIImage(systemName: "bell")
        imageView.tintColor = color
    }

}
