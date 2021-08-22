//
//  FoodCellTableViewCell.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 20/04/2021.
//

import UIKit

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func foodCellContent(at food : Food) {
        //convert Data to UIImage
        foodImage.image =  UIImage(data:food.foodImg!,scale:1.0)!
        descriptionLabel.text = food.foodDesc
        dateLabel.text = food.date
    }
    
}
