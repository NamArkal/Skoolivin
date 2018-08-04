//
//  ProfileViewController.swift
//  Skoolivin
//
//  Created by Namrata A on 4/29/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var imageSelector: UIImageView!
    @IBOutlet weak var universityField: UITextField!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    let picker = UIImagePickerController()
    var databaseReference: DatabaseReference?
    var storageReference: StorageReference?
    
    @IBAction func selectImage(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image =  info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageSelector.image = image
            let chosen = UIImageJPEGRepresentation(image, 0.8)
            self.storePhotoInStorage(imageData: chosen!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func storePhotoInStorage(imageData: Data) {
        
        let imagePath = "user_photos/" + Auth.auth().currentUser!.uid + "/\(Auth.auth().currentUser!.uid).jpg"
        
        // set content type to “image/jpeg” in firebase storage metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // create a child node at imagePath with imageData and metadata
        storageReference?.child(imagePath).putData(imageData, metadata: metadata) { (metadata, error) in
            
            if let error = error {
                print("Error uploading: \(error)")
                return
            }
            
            
            // use sendMessage to add imageURL to database
            self.storeImageDataOnDatabase(imageData:  ["profileImageUrl":(self.storageReference?.child((metadata?.path)!).description)!])
        }
    }
    
    func storeImageDataOnDatabase(imageData: [String: String]) {
        let imagePath = "users/" + Auth.auth().currentUser!.uid + "/"
        databaseReference?.child(imagePath).setValue(imageData)
    }
    
    @IBAction func updateInfo(_ sender: UIButton) {
        if (nameField.text == nil) {
            showAlert(withAlertMessage: "Empty Name Field")
            return
        }
        
        if (dobField.text == nil) {
            showAlert(withAlertMessage: "Empty DOB Field")
            return
        }
        
        if (universityField.text == nil) {
            showAlert(withAlertMessage: "Empty University Field")
            return
        }
        
        //extract values from fields
        let name = nameField.text!
        let dob = dobField.text!
        let university = universityField.text!
        
        
        // Store the user data
        storeUserDataOnDatabase(withName: name, dob: dob, university: university)
        
        // Navigate to Main Screen
        showAlert(withAlertMessage: "Updated!")
    }
    
    func storeUserDataOnDatabase(withName name: String, dob: String, university: String) {
        print("function Called")
        databaseReference?.child("users").child(Auth.auth().currentUser!.uid).child("name").setValue(name)
        databaseReference?.child("users").child(Auth.auth().currentUser!.uid).child("dob").setValue(dob)
        databaseReference?.child("users").child(Auth.auth().currentUser!.uid).child("university").setValue(university)
    }
    
    func showAlert(withAlertMessage alertMessage: String) {
        let alert = UIAlertController(title: "Message", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        nameField.delegate = self
        dobField.delegate = self
        universityField.delegate = self
        
        databaseReference = Database.database().reference()
        storageReference = Storage.storage().reference()
        
        let font = UIFont(name: "Sinhala Sangam MN", size: 13)
        logoutButton.setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): font as Any], for: .normal)
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
    
    // When Return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // when tapped elsewhere than fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
