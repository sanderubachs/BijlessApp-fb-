//
//  DetailVC.swift
//  BijlessApp
//
//  Created by issd on 13/12/2018.
//  Copyright © 2018 Fontys. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var onderwerpLabel: UILabel!
    @IBOutlet weak var beschrijvingLabel: UILabel!
    @IBOutlet weak var taalLabel: UILabel!
    @IBOutlet weak var datumLabel: UILabel!
    
    @IBOutlet weak var reactieLabel: UILabel!
    @IBOutlet weak var reactieInput: UITextField!
    @IBAction func postReactie(_ sender: Any) {
        reactieLabel.text = reactieInput.text
        reactieInput.text = ""
    }
    
        var naamVar = String()
        var onderwerpVar = String()
        var beschrijvingVar = String()
        var taalVar = String()
        var datumVar = String()

        
    override func viewDidLoad() {
            super.viewDidLoad()
            
            naamLabel.text = naamVar
            onderwerpLabel.text = onderwerpVar
            beschrijvingLabel.text = beschrijvingVar
            taalLabel.text = taalVar
            datumLabel.text = datumVar
        
        print("naam: \(naamVar)")
        print("ondrperwe: \(onderwerpVar)")
        
        //krijgt na toevoeging hier de eerste data uit array binnen..??

        }
        
        func commonInit(_ title: String) {
            self.title = title
        }
        
    func commonInit2(naam: String, onderwerp: String, datum: String, taal: String, beschrijving: String) {
            naamVar = naam
            onderwerpVar = onderwerp
            datumVar = datum
            beschrijvingVar = beschrijving
            taalVar = taal
        }
    }

