//
//  ViewController.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 10/04/2021.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var savedImage:UIImage?
    
    private var displayCurrentDays : String {
        get {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let formattedDate = dateFormatter.string(from: currentDate)
            
            return formattedDate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    @IBAction func addJournalButtonPressed(_ sender: UIButton) {
        initCamera()
    }
    
    func initCamera() {
        //view controller that manage system interfaces for taking pictures,videos,choosing media in library
        let picker = UIImagePickerController()
        //source type to be present by controller
        picker.sourceType = .camera
        //assign delegate, allow to get image out of picker object
        picker.delegate = self
        //allows user to crop image before use photo
        picker.allowsEditing = true
        //present the camera
        present(picker, animated: true, completion: nil)
    }
}

extension HomeVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //tells delegate user cancel pick operation
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss picker
        dismiss(animated: true, completion: nil)
    }
    //tells delegate user pick image/video
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        //dismiss picker before setup other things
        dismiss(animated: true)
        
        //info , info dictionary datatype contains image/video taken by user
        
        //get image from dictionary
        //.originalImage, allows get image straight of camera
        //.editedImage, allows to get cropped image
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //save image to variable
            savedImage = image
            print("Image receive")
            //perform segue after receive image
            self.performSegue(withIdentifier: K.goToSaveFoodVCSegues, sender: self)
            
        }
    }
    //preparation for segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == K.goToSaveFoodVCSegues {
            let destinationVC = segue.destination as! SaveFoodVC
            //send image to other VC
            destinationVC.receiveImage = savedImage
        }
    }
}

//MARK:- Private methods

extension HomeVC {
    
    private func renderView() {
        addButton.layer.cornerRadius = 25.0
        dayLabel.text = displayCurrentDays
    }
}

