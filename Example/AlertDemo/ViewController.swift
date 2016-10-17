//
//  ViewController.swift
//  AlertDemo
//
//  Created by Andrew Lloyd on 14/10/2016.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let alert = AlertVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showAlertButonTapped(_ sender: AnyObject) {
        
        alert.backgroundColor = UIColor.yellow
        alert.subLabelText = "subLabel"
        
        if alert.labelText.characters.count == 0 {
            alert.labelText = "Message"
        }
        
        alert.forcedAlert = true
        alert.labelFont = UIFont.boldSystemFont(ofSize: 40)
        alert.okCompletion = {
            self.alert.labelText = "Message2"
        }
        alert.showAlert()
    }

}

