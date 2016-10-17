//
//  AlertVC.swift
//  OxCEPT
//
//  Created by Andrew Lloyd on 14/09/2016.
//  Copyright (c) 2015 Nodes. All rights reserved.
//

import UIKit

enum AlertType {
    
    case Error, ErrorCancel, Success, RedAlert
}

class AlertVC: UIViewController {

    static var alertShown = false
    
    var cornerRadius : CGFloat = 7.0
    var canBeDismissedFromBackground:Bool = false

    //Param vars
    var iconImage:UIImage?
    var labelText:String = ""
    var subLabelText:String = ""
    var extraSubLabelText:String = ""
    var forcedAlert:Bool = false
    
    var type: AlertType = AlertType.Error
    var okButtonText:String = "OK"
    var okCompletion: (() -> Void)?
    var cancelButtonText:String = "Cancel"
    var cancelCompletion: (() -> Void)?
    var bottomExtraButtonText:String = ""
    var bottomExtraButtonCompletion: (() -> Void)?
    var shouldShowBottomExtraButton = false
    
    var labelFont: UIFont?
    var subLabelFont: UIFont?
    var extraSubLabelFont: UIFont?
    var buttonFont: UIFont?
    var bottomExtraButtonFont: UIFont?
    
    var backgroundColor: UIColor = UIColor.white
    var okButtonBackgroundColor: UIColor = UIColor.white
    var cancelButtonBackgroundColor: UIColor = UIColor.white
    
    //UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var singleOKButton: UIButton!
    @IBOutlet weak var bottomExtraButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var extraSubLabelTextHeight: NSLayoutConstraint!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var extraSublabel: UILabel!
    
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var subLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subLabelBottomConstraint: NSLayoutConstraint!
    
    
    //MARK: init Helpers
    public func setupWith(title:String?, subText:String?, image:UIImage?, okTitle:String?, cancelTitle:String?, bottomExtraButtonTitle:String?, forced:Bool, okCompletion:(() -> Void)?, cancelCompletion:(() -> Void)?, bottomExtraButtonCompletion:(() -> Void)?, backgroundColor: UIColor?, buttonColors: UIColor?) {
        
        let alert = AlertVC(nibName: "AlertVC", bundle: nil)
        
        if let title = title {
            alert.labelText = title
        }
        if let subText = subText {
            alert.subLabelText = subText
        }
        if let okTitle = okTitle {
            alert.okButtonText = okTitle
        }
        if let cancelTitle = cancelTitle {
            alert.cancelButtonText = cancelTitle
        }
        if let image = image {
            alert.iconImage = image
        }
        if let bottomExtraButtonTitle = bottomExtraButtonTitle{
            alert.bottomExtraButtonText = bottomExtraButtonTitle
        }
        
        alert.forcedAlert = forced
        alert.okCompletion = okCompletion
        alert.cancelCompletion = cancelCompletion
        alert.bottomExtraButtonCompletion = bottomExtraButtonCompletion
        
        if let backgroundColor = backgroundColor {
            alert.backgroundColor = backgroundColor
        }
        if let buttonColors = buttonColors {
            alert.okButtonBackgroundColor = buttonColors
            alert.cancelButtonBackgroundColor = buttonColors
        }
    }
    
    public func showForceAlert(title:String, okTitle:String?, cancelTitle:String?, okCompletion:(() -> Void)?, cancelCompletion:(() -> Void)?) {
        
        AlertVC.alertShown = false
        
        let alert = AlertVC(nibName: "AlertVC", bundle: nil)
        
        alert.labelText = title
        alert.forcedAlert = true
        if let okTitle = okTitle {
            alert.okButtonText = okTitle
        }
        if let cancelTitle = cancelTitle {
            alert.cancelButtonText = cancelTitle
        }
        
        alert.okCompletion = okCompletion
        alert.cancelCompletion = cancelCompletion
        
        alert.showAlert()
    }
    
    public func showError(message:String, forced:Bool) {
        
        self.showForceAlert(title: message, okTitle: nil, cancelTitle: nil, okCompletion: nil, cancelCompletion: nil)
    }
    
    //MARK: Setup & Display
    
    func showAlert() {
        
        if !AlertVC.alertShown {
            if var topVC = self.topVC() {
                
                if topVC is UITabBarController {
                    
                    topVC = (topVC as! UITabBarController).selectedViewController!
                }
                
                topVC.addChildViewController(self)
                self.view.frame = topVC.view.bounds
                self.view.alpha = 0
                topVC.view.addSubview(self.view)
                self.didMove(toParentViewController: topVC)
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.view.alpha = 1
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAlert()
    }
    
    func setupAlert() {
        
        AlertVC.alertShown = true
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize()
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 3
        
        if shouldShowBottomExtraButton{
            bottomExtraButton.isHidden = false
        }else{
            bottomExtraButton.isHidden = true
        }
        
        //set constrainsts depending on content
        
        if extraSubLabelText.isEmpty{
            extraSubLabelTextHeight.constant = 0.0
        }else{
            extraSubLabelTextHeight.constant = 14.0
            extraSublabel.text = extraSubLabelText
        }
        
        if let image = iconImage {
            imageView.image = image
        }
        else {
            imageTopConstraint.constant = 0.0
        }
        
        if labelText.isEmpty {
            titleHeightConstraint.constant = 0.0
        }
        
        
        if subLabelText.isEmpty {
            subLabelHeightConstraint.constant = 0.0
            subLabelBottomConstraint.constant = 0.0
        }
        
        self.view.layoutIfNeeded()
        
        subLabel.text = subLabelText
        label.text = labelText
        okButton.setTitle(okButtonText, for: UIControlState.normal)
        singleOKButton.setTitle(okButtonText, for: UIControlState.normal)
        cancelButton.setTitle(cancelButtonText, for: UIControlState.normal)
        
        if type == AlertType.RedAlert {
            self.subLabel.textColor = UIColor.red
        }
        
        okButton.backgroundColor = okButtonBackgroundColor
        singleOKButton.backgroundColor = okButtonBackgroundColor
        cancelButton.backgroundColor = cancelButtonBackgroundColor
        contentView.backgroundColor = backgroundColor
        
        label.font = labelFont
        subLabel.font = subLabelFont
        extraSublabel.font = extraSubLabelFont
        
        if shouldShowBottomExtraButton {
            bottomExtraButton.setTitle(bottomExtraButtonText, for: .normal)
            bottomExtraButton.titleLabel?.font = bottomExtraButtonFont
        }
        else {
            bottomExtraButton.alpha = 0
        }
        
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        if (self.imageView.image == nil) {
            imageViewHeightContraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
        if(forcedAlert) {
            singleOKButton.superview?.bringSubview(toFront: singleOKButton)
        }
    }
    
    // MARK: - Navigation
    func topVC() -> UIViewController? {
        
        if var topVC = UIApplication.shared.keyWindow?.rootViewController {
            
            while topVC.presentedViewController != nil  {
                if topVC.presentedViewController is AlertVC == false {
                    topVC = topVC.presentedViewController!
                }
            }
            
            return topVC
            
        }
        
        return nil
    }
    
    //MARK: Actions
    
    @IBAction func viewTapped(sender: AnyObject) {
        
        if canBeDismissedFromBackground {
            removeSelf()
        }
    }
    
    @IBAction func okButtonPressed(sender: UIButton) {
    
        if let completion = self.okCompletion {
            
            completion()
        }
        
        removeSelf()
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        
        if let completion = self.cancelCompletion {
            
            completion()
        }
        
        removeSelf()
    }
    
    
    @IBAction func bottomExtraButtonAction(sender: AnyObject) {
        
        if let completion = self.bottomExtraButtonCompletion {
            
            completion()
        }
        
        removeSelf()
    }
    
    func removeSelf() {
        
        self.willMove(toParentViewController: nil)
        AlertVC.alertShown = false

        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            
            self.view.alpha = 0
            
            }) { (finished) -> Void in
                
                if(finished) {

                    self.view.removeFromSuperview()
                    self.removeFromParentViewController()
                    
                }
                
        }
    }
}
