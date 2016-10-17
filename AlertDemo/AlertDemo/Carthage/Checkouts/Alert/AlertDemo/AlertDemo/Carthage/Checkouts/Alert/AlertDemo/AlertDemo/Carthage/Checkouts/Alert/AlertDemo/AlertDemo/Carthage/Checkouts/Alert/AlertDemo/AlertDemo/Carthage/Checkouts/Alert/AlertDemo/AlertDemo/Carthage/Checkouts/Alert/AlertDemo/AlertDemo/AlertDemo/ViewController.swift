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
        alert.subLabelText = "subLabel"
        alert.labelText = "Message"
        alert.forcedAlert = true
        alert.labelFont = UIFont.boldSystemFont(ofSize: 40)
        alert.showAlert()
    }

}

