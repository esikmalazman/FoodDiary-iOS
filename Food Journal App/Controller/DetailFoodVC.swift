//
//  DetailFoodVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 20/04/2021.
//

import UIKit

class DetailFoodVC: UIViewController
{

    var date:String?
    var desc:String?
    var image : UIImage?
    @IBOutlet weak var detailFoodDate: UILabel!
    @IBOutlet weak var detailFoodDescription: UILabel!
    @IBOutlet weak var detailFoodImage: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        detailFoodDate.text = date
        detailFoodDescription.text = desc
        detailFoodImage.image = image
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
