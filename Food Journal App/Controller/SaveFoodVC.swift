//
//  SaveFoodVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 15/04/2021.
//

import UIKit

class SaveFoodVC: UIViewController {
    

    
    var receiveImage : UIImage?
    

    @IBOutlet weak var capturedImage: UIImageView!
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        capturedImage.image = receiveImage
    
        // Do any additional setup after loading the view.
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
