//
//  ComposeViewController.swift
//  BijlessApp
//
//  Created by issd on 13/12/2018.
//  Copyright © 2018 Fontys. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    @IBOutlet weak var inputOnderwerp: UITextField!
    @IBOutlet weak var inputNaam: UITextField!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
    }
    
    @IBAction func addPost(_ sender: Any) {
        let naamInput = inputNaam.text
        let onderwerpInput = inputOnderwerp.text
        
        //input in database zetten
        ref?.child("Posts").childByAutoId().setValue([
            "postNaam": naamInput!,
            "postOnderwerp": onderwerpInput!
            ])
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
