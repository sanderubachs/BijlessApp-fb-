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
    
        var naamVar = String()
        var onderwerpVar = String()
        
    override func viewDidLoad() {
            super.viewDidLoad()
            
            naamLabel.text = naamVar
            onderwerpLabel.text = onderwerpVar
        
        print("naam: \(naamVar)")
        print("ondrperwe: \(onderwerpVar)")
        
        //krijgt na toevoeging hier de eerste data uit array binnen..??

        }
        
        func commonInit(_ title: String) {
            self.title = title
        }
        
        func commonInit2(naam: String, onderwerp: String) {
            naamVar = naam
            onderwerpVar = onderwerp
        }
    }

