//
//  AlertVC.swift
//  OxCEPT
//
//  Created by Andrew Lloyd on 14/09/2016.
//  Copyright (c) 2015 Nodes. All rights reserved.
//

import UIKit

public enum AlertType {
    
    case Error
    case ErrorCancel
    case Success
    case RedAlert
}

public class AlertVC: UIViewController {

    public static var alertShown = false
    
    public var cornerRadius : CGFloat = 7.0
    public var canBeDismissedFromBackground:Bool = false

    //Param vars
    public var iconImage:UIImage?
    public var labelText:String = ""
    public var subLabelText:String = ""
    public var extraSubLabelText:String = ""
    public var forcedAlert:Bool = false
    
    public var type: AlertType = AlertType.Error
    public var okButtonText:String = "OK"
    public var okCompletion: (() -> Void)?
    public var cancelButtonText:String = "Cancel"
    public var cancelCompletion: (() -> Void)?
    public var bottomExtraButtonText:String = ""
    public var bottomExtraButtonCompletion: (() -> Void)?
    public var shouldShowBottomExtraButton = false
    
    public var labelFont: UIFont?
    public var subLabelFont: UIFont?
    public var extraSubLabelFont: UIFont?
    public var buttonFont: UIFont?
    public var bottomExtraButtonFont: UIFont?
    
    public var backgroundColor: UIColor = UIColor.white
    public var okButtonBackgroundColor: UIColor = UIColor.white
    public var cancelButtonBackgroundColor: UIColor = UIColor.white
    
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
    
    convenience init() {
        self.init(nibName: "AlertVC", bundle: Bundle(for: AlertVC.self))
    }
    
    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public static func showAlertInVC(caller: UIViewController) {
        
        let podBundle = Bundle(for: AlertVC.self)
        
        let bundleURL = podBundle.url(forResource: "Alert", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        let vc = AlertVC.init(nibName: "AlertVC", bundle: bundle)
        caller.present(vc, animated: true, completion: nil)
    }
    
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
    
    public func showError(message:String) {
        
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
    
    override public func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
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
