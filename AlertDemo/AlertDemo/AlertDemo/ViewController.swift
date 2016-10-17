//
//  ViewController.swift
//  AlertDemo
//
//  Created by Andrew Lloyd on 14/10/2016.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showAlertButonTapped(_ sender: AnyObject) {
        let alert = AlertVC()
        alert.backgroundColor = UIColor.yellow
        alert.okButtonBackgroundColor = UIColor.red
        alert.subLabelText = "subLabel"
        alert.extraSubLabelText = "more info!"
        alert.labelText = "Message"
        alert.forcedAlert = true
        alert.cornerRadius = 20
        alert.labelFont = UIFont.boldSystemFont(ofSize: 40)
        alert.shouldShowBottomExtraButton = true
        
        alert.bottomExtraButtonText = "Footer"
        alert.bottomExtraButtonFont = UIFont.boldSystemFont(ofSize: 40)
        alert.bottomExtraButtonCompletion = {
            print("footer pressed")
        }
        alert.showAlert()
    }

}

