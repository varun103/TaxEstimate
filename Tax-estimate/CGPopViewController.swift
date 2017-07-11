//
//  CGPopViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 5/13/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

protocol CGPopupViewControllerDelegate {
    func valuesChanged()
}

class CGPopupViewController: UIViewController {
    
    var capitalGains: CapitalGains?
    
    var delegate: CGPopupViewControllerDelegate?
    
    @IBOutlet weak var shortTermGainsAmount: CustomTextField!
    
    @IBOutlet weak var longTermGainsAmount: CustomTextField!
    
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        self.popUpView.layer.cornerRadius = 12.0
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.shortTermGainsAmount.inputAccessoryView = CustomKeyboard.keyboardWDoneButton(view: self.view)
        self.longTermGainsAmount.inputAccessoryView = CustomKeyboard.keyboardWDoneButton(view: self.view)
        self.showAnimate()
        displayExistingValues()
    }
    
    @IBAction func exitPopup(_ sender: Any) {
        if let x = Int(self.shortTermGainsAmount.text!) {
            self.capitalGains?.setShortTermGains(amount: x)
        } else {
            self.capitalGains?.setShortTermGains(amount: 0)
        }

        if let x = Int(self.longTermGainsAmount.text!) {
            self.capitalGains?.setLongTermGains(amount: x)
        } else {
            self.capitalGains?.setLongTermGains(amount: 0)
        }
        self.removeAnimate()
    }
    
    @IBAction func gainsEntered(_ sender: Any) {
        self.capitalGains?.setShortTermGains(amount: Int(self.shortTermGainsAmount.text!)!)
        self.capitalGains?.setLongTermGains(amount: Int(self.longTermGainsAmount.text!)!)
    }
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                self.delegate?.valuesChanged()
            }
        });
    }
    
    private func displayExistingValues() {
        if !(capitalGains?.shortTermGains == 0 && capitalGains?.longTermGains == 0) {
            if (capitalGains?.shortTermGains != 0){
                self.shortTermGainsAmount.text = "\(capitalGains?.shortTermGains ?? 0)"
            }
            if (capitalGains?.longTermGains != 0) {
                self.longTermGainsAmount.text = "\(capitalGains?.longTermGains ?? 0)"
            }
        }
    }
}
