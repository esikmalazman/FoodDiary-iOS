//
//  FoodCellTableViewCell.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 20/04/2021.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib()
    {
        //initialise design from .xib
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
