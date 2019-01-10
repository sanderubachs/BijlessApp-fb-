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
    @IBOutlet weak var leeftijdInput: UITextField!
    @IBOutlet weak var semesterInput: UITextField!
    @IBOutlet weak var richtingInput: UITextField!
    @IBOutlet weak var specialisatieInput: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    //    var isSignIn:Bool = true
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.hideKeyboardWhenTappedAround()
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(registerViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
                    let inputLeeftijd = self.leeftijdInput.text
                    let inputSemester = self.semesterInput.text
                    let inputRichting = self.richtingInput.text
                    let inputSpecialisatie  = self.specialisatieInput.text
                    
                    //input in database zetten
                    self.ref?.child("Users").childByAutoId().setValue([
                        "userNaam": inputNaam!,
                        "userLeeftijd": inputLeeftijd!,
                        "userEmail": email,
                        "userSemester": inputSemester!,
                        "userRichting": inputRichting!,
                        "userSpecialisatie": inputSpecialisatie!
                        ])
                } else {
                    return
                }
            }
        }
    }
}

