//
//  SaveFoodVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 15/04/2021.
//

import UIKit
import CoreData

class SaveFoodVC: UIViewController {
    
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var journalDescriptionTextField: UITextField!
    
    var receiveImage : UIImage?
    
    private var journalDescription : String {
        get {
            guard let description = journalDescriptionTextField.text else { fatalError("description failed to display, description is nil")}
            return description
        }
        set {
            journalDescriptionTextField.placeholder = newValue
        }
    }
    
    private var currentDate : String {
        get {
            let dateFormatter = DateFormatter()
            let date = Date()
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .long
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }
    }
    private let persistentManager = PersistentManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    @IBAction func doneJournalButtonPressed(_ sender: UIButton) {
        validateTextField()
        //create notification to the notification center observer, call fetchFood() when new object loads up
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"),object: nil)
    }
    
    func didSaveFoodJournal() {
        //create Food Object for data model in core data
        
        //1.create a new food object in context
        let newFood = Food(context: persistentManager.context)
        //assign data to property
        newFood.foodDesc = journalDescription
        newFood.date = currentDate
        //convert UIImage to Data
        newFood.foodImg = receiveImage?.jpegData(compressionQuality: 1)
        
        //2. save data, through manage object context
        persistentManager.saveContext()
    }
}

extension SaveFoodVC : UITextFieldDelegate {
    //method to tel
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if  journalDescriptionTextField.text != "" {
            resignFirstResponder()
            return true
        }
        else {
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- Private methods

extension SaveFoodVC {
    
    private func renderView() {
        doneButton.layer.cornerRadius = 25.0
        capturedImage.image = receiveImage
        //assign textfield delegate
        journalDescriptionTextField.delegate = self
        
    }
    
    private func validateTextField() {
        //prevent empty textfield
        if  journalDescription != "" {
            didSaveFoodJournal()
            //go to welcome VC
            self.dismiss(animated: true, completion: nil)
        } else {
            journalDescription = "Food Description?"
        }
    }
}
