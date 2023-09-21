//
//  CharacterCollectionViewCell.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 31/08/23.
//

import UIKit

protocol CharacterCollectionViewCellDelegate: AnyObject {
    func fetchImage(url: String, completion: @escaping ((Data?) -> Void))
}

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: CharacterCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(name: String, status: String, imageUrl: String) {
        statusLabel.text = status
        nameLabel.text = name
        
        delegate?.fetchImage(url: imageUrl) { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }

}
