//
//  EpisodeTableViewCell.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 24/08/23.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var airedDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBorderView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(airedDate: String ,name: String ,episodeNumber: String) {
        airedDateLabel.text = airedDate
        nameLabel.text = name
        episodeNumberLabel.text = episodeNumber
    }
    
    func configureBorderView() {
        borderView.layer.borderColor = UIColor.red.cgColor
        borderView.layer.borderWidth = 2
        borderView.layer.cornerRadius = 8
    }
}
