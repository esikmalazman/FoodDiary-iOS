//
//  SaveFoodVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 15/04/2021.
//

import UIKit

class SaveFoodVC: UIViewController
{
    

    
    var receiveImage : UIImage?
    //get current date
    let currentDate = Date()
    //initialise date formatter
    let dateFormatter = DateFormatter()

    @IBOutlet weak var capturedImage: UIImageView!
    
    @IBOutlet weak var journalDescriptionTextField: UITextField!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        capturedImage.image = receiveImage
        journalDescriptionTextField.delegate = self
    
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func doneJournalButtonPressed(_ sender: UIButton)
    {
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        
        //get date time string from date object
        let formatDate = dateFormatter.string(from : currentDate)
        print(journalDescriptionTextField.text!)
        
        let description = journalDescriptionTextField.text
        
      
        
     
        //prevent empty textfield
        if  journalDescriptionTextField.text != ""
        {
            //go to welcome VC
            self.dismiss(animated: true, completion: nil)
            
        }
        else
        {
            journalDescriptionTextField.placeholder = "Food Description?"
        }
        
    
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

extension SaveFoodVC : UITextFieldDelegate
{
    //method to tel
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if  journalDescriptionTextField.text != ""
        {
            resignFirstResponder()
            return true
        }
        else
        {
            return false
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        if segue.identifier == K.goToFoodJournalVCSegues
//        {
//            let destinationVC = segue as!  FoodJournalVC
//        }
    }
}
