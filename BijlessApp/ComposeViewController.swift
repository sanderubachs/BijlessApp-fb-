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
    @IBOutlet weak var inputTaal: UITextField!
    @IBOutlet weak var inputBeschrijving: UITextView!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
    }
    
    @IBAction func addPost(_ sender: Any) {
        let naamInput = inputNaam.text
        let onderwerpInput = inputOnderwerp.text
        let taalInput = inputTaal.text
        let beschrijvingInput = inputBeschrijving.text
//        let datumInput = "Vandaag"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let date = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let datumInput = formatter.string(from: date!)
        
//        print(datumInput)
        
        //input in database zetten
        ref?.child("Posts").childByAutoId().setValue([
            "postNaam": naamInput!,
            "postOnderwerp": onderwerpInput!,
            "postTaal": taalInput!,
            "postBeschrijving": beschrijvingInput!,
            "postDatum": datumInput
            ])
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
