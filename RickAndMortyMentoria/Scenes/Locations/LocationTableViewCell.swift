//
//  LocationTableViewCell.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 10/08/23.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(name: String, type: String, dimension: String) {
        nameLabel.text = "Name: \(name)"
        typeLabel.text = "Type: \(type)"
        dimensionLabel.text = "Dimension: \(dimension)"
    }
}
