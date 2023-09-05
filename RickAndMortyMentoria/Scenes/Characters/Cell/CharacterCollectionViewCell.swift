//
//  CharacterCollectionViewCell.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 31/08/23.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(name: String, status: String, imageUrl: String) {
        
        statusLabel.text = status
        nameLabel.text = name
    }

}
