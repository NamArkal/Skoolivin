//
//  NewPostViewController.swift
//  Skoolivin
//
//  Created by Namrata A on 4/29/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewPostViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var endDateField: UITextField!
    @IBOutlet weak var foodField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var majorField: UITextField!
    @IBOutlet weak var partyField: UITextField!
    @IBOutlet weak var petsField: UITextField!
    @IBOutlet weak var roomsField: UITextField!
    @IBOutlet weak var sharedField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var selectImageView: UIImageView!
    
    var takenImage: UIImage!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Post"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black,NSAttributedStringKey.font: UIFont(name: "Sinhala Sangam MN", size: 16) as Any]
        let font = UIFont(name: "Sinhala Sangam MN", size: 13)
        logoutButton.setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font as Any], for: .normal)
        
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
            } else {
                imagePicker.sourceType = .photoLibrary
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func showAlert(withAlertMessage alertMessage: String) {
        let alert = UIAlertController(title: "Message", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func handleLogout(_ sender: UIBarButtonItem) {
        handleLogout()
    }
    
    func handleLogout(){
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        
    }
    
    override var shouldAutorotate: Bool{
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    @IBAction func postPressed(_ sender: UIButton) {
        
        if (addressField.text == nil && addressField.text != addressField.placeholder) {
            showAlert(withAlertMessage: "Empty Address Field")
            return
        }
        
        if (commentsField.text == nil && commentsField.text != commentsField.placeholder) {
            showAlert(withAlertMessage: "Empty Comments Field")
            return
        }
        
        if (startDateField.text == nil && startDateField.text != startDateField.placeholder) {
            showAlert(withAlertMessage: "Empty Start Date Field")
            return
        }
        
        if (endDateField.text == nil && endDateField.text != endDateField.placeholder) {
            showAlert(withAlertMessage: "Empty End Date Field")
            return
        }
        
        if (foodField.text == nil && foodField.text != foodField.placeholder) {
            showAlert(withAlertMessage: "Empty Food Field")
            return
        }
        
        if (yearField.text == nil && yearField.text != yearField.placeholder) {
            showAlert(withAlertMessage: "Empty Year Field")
            return
        }
        
        if (majorField.text == nil && majorField.text != majorField.placeholder) {
            showAlert(withAlertMessage: "Empty Major Field")
            return
        }
        
        if (partyField.text == nil && partyField.text != partyField.placeholder) {
            showAlert(withAlertMessage: "Empty Partying Field")
            return
        }
        
        if (petsField.text == nil && petsField.text != petsField.placeholder) {
            showAlert(withAlertMessage: "Empty Pets Field")
            return
        }
        
        if (roomsField.text == nil && roomsField.text != roomsField.placeholder) {
            showAlert(withAlertMessage: "Empty Rooms Field")
            return
        }
        
        if (sharedField.text == nil && sharedField.text != sharedField.placeholder) {
            showAlert(withAlertMessage: "Empty Shared Rooms Field")
            return
        }
        
        if (priceField.text == nil && priceField.text != priceField.placeholder) {
            showAlert(withAlertMessage: "Empty Price Field")
            return
        }
        
        if (distanceField.text == nil && distanceField.text != distanceField.placeholder) {
            showAlert(withAlertMessage: "Empty Distance Field")
            return
        }
        
        if (takenImage == nil) {
            showAlert(withAlertMessage: "No Image Selected")
            return
        }
        
        let rooms: Int? = Int(roomsField.text!)
        let shared: Int? = Int(sharedField.text!)
        
        let newPost = Post(address: addressField.text!, comments: commentsField.text!, endDate: endDateField.text!, food: foodField.text!, major: majorField.text!, partying: partyField.text!, pets: petsField.text!, rooms: rooms!, shared: shared!, startDate: startDateField.text!, year: yearField.text!, price: priceField.text!, distance: distanceField.text!, image: takenImage)
        newPost.save()
        showAlert(withAlertMessage: "Post saved!")
    }
    
}

extension NewPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(image)
        takenImage = image
        self.selectImageView.image = takenImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
