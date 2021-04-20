//
//  SaveFoodVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 15/04/2021.
//

import UIKit
import CoreData

class SaveFoodVC: UIViewController
{
    

    
    var receiveImage : UIImage?
    //get current date
    let currentDate = Date()
    //initialise date formatter
    let dateFormatter = DateFormatter()

    @IBOutlet weak var capturedImage: UIImageView!
    
    @IBOutlet weak var journalDescriptionTextField: UITextField!
    
    //UIApplication.shared.delegate as! AppDelegate, allow access to app delegate
    // .persistentContainer, allow access to persistent container(db)
    //.viewContext, allow to manage reference to persistent container to store & retrieve from core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        capturedImage.image = receiveImage
        //assign textfield delegate
        journalDescriptionTextField.delegate = self
        

    }
    
    
    
    
    @IBAction func doneJournalButtonPressed(_ sender: UIButton)
    {
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        
        //get date time string from date object
        let formatDate = dateFormatter.string(from : currentDate)
        print(journalDescriptionTextField.text!)
        let description = journalDescriptionTextField.text
        
 
//            let foodImage = UIImage.pngData(capturedImage) as NSData?
     
        
    
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
        
        //create data in core data
        
        //1.create a new food object in context
        
        let newFood = Food(context: self.context)
        //assign data to property
        newFood.foodDesc = description
        newFood.date = formatDate
        //convert UIImage to Data
        newFood.foodImg = receiveImage?.jpegData(compressionQuality: 1)
        
        //2. save data, through manage object context
        do
        {
            print("Food is saved")
            try self.context.save()
        }
        catch
        {
            print(error)
        }
        
        //re-fetch the data
        
        //create notification to the notification center observer
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"),object: nil)
        
        
    
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
