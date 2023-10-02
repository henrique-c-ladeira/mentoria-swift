//
//  CharacterDetailView.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 02/10/23.
//

import UIKit

class CharacterDetailView: UIView {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(value: String, type: String) {
        valueLabel.text = value
        typeLabel.text = type
        configureTypeView()
    }
    
    func configureTypeView() {
        typeView.backgroundColor = .lightGray
        typeView.layer.borderColor = UIColor.gray.cgColor
        typeView.layer.cornerRadius = 8
        typeView.layer.masksToBounds = true
        typeView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

}
