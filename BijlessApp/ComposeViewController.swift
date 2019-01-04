//
//  ComposeViewController.swift
//  BijlessApp
//
//  Created by issd on 13/12/2018.
//  Copyright © 2018 Fontys. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ComposeViewController: UIViewController {

    @IBOutlet weak var inputOnderwerp: UITextField!
    @IBOutlet weak var inputTaal: UITextField!
    @IBOutlet weak var inputBeschrijving: UITextView!
    
    var ref: DatabaseReference!
    var ref2: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
    }
    
    @IBAction func addPost(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            print("uid: \(uid)")
            print("email: \(email!)")
            
            self.ref2 = Database.database().reference().child("Users")
            let query = self.ref2.queryOrdered(byChild: "userEmail").queryEqual(toValue: email)
            query.observe(.value, with: { (snapshot) in
                for user_child in (snapshot.children) {
                    let user_snap = user_child as! DataSnapshot
                    let dict = user_snap.value as! [String: String?]
                    
                    // DEFINE VARIABLES FOR LABELS
                    let voorNaam = dict["userNaam"] as? String
                    let achterNaam = dict["userAchternaam"] as? String
        
                    //input variables
                    let naamInput = "\(voorNaam!) \(achterNaam!)"
                    let onderwerpInput = self.inputOnderwerp.text
                    let taalInput = self.inputTaal.text
                    let beschrijvingInput = self.inputBeschrijving.text
                    
//       datum input
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let date = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let datumInput = formatter.string(from: date!)
        
//        print(datumInput)
        
        //input in database zetten
            self.ref?.child("Posts").childByAutoId().setValue([
            "postNaam": naamInput,
            "postOnderwerp": onderwerpInput!,
            "postTaal": taalInput!,
            "postBeschrijving": beschrijvingInput!,
            "postDatum": datumInput
            ])
        }
    }
    )}
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
