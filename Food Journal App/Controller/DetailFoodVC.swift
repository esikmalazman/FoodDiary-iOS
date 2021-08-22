//
//  DetailFoodVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 20/04/2021.
//

import UIKit

class DetailFoodVC: UIViewController {
    
    @IBOutlet weak var detailFoodDate: UILabel!
    @IBOutlet weak var detailFoodDescription: UILabel!
    @IBOutlet weak var detailFoodImage: UIImageView!
    
    var date : String?
    var desc : String?
    var image : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func renderView() {
        detailFoodDate.text = date
        detailFoodDescription.text = desc
        detailFoodImage.image = image
    }
}
