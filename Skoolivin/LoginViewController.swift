//
//  ViewController.swift
//  Skoolivin
//
//  Created by Namrata A on 4/17/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginRegisterSegment: UISegmentedControl!
    @IBOutlet weak var loginRegisterButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var isLogin = true
    
    var mainController: MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginRegisterChanged(_ sender: UISegmentedControl) {
        isLogin = !isLogin
        if isLogin {
            loginRegisterButton.setTitle("Login", for: .normal)
        } else {
            loginRegisterButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func loginRegisterButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if isLogin{
                Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
                    if let u = user {
                        self.performSegue(withIdentifier: "homePage", sender: self)
                        print("user: ", u)
                    } else {
                        print(err as Any)
                    }
                }
            } else {
                Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
                    if let u = user {
                        self.performSegue(withIdentifier: "homePage", sender: self)
                        print("user: ", u)
                    } else {
                        print(err as Any)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

