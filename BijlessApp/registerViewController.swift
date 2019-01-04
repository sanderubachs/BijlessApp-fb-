//
//  registerViewController.swift
//  BijlessApp
//
//  Created by issd on 21/12/2018.
//  Copyright © 2018 Fontys. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class registerViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var naamInput: UITextField!
    @IBOutlet weak var achternaamInput: UITextField!
    @IBOutlet weak var leeftijdInput: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    //    var isSignIn:Bool = true
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        //email validation
        if let email = emailInput.text, let pass = passwordInput.text{
            
            //check if it's sign in or register
            //register the user
            Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
                // ...
                if let user = authResult?.user {
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    let inputNaam = self.naamInput.text
                    let inputAchter = self.achternaamInput.text
                    let inputLeeftijd = self.leeftijdInput.text
                    
                    //input in database zetten
                    self.ref?.child("Users").childByAutoId().setValue([
                        "userNaam": inputNaam!,
                        "userAchternaam": inputAchter!,
                        "userLeeftijd": inputLeeftijd!,
                        "userEmail": email
                        ])
                } else {
                    return
                }
            }
        }
    }
}

