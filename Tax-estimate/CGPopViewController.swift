//
//  CGPopViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 5/13/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit


class CGPopupViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var shortTermGainsAmount: CustomTextField!
    
    @IBOutlet weak var longTermGainsAmount: CustomTextField!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    @IBAction func exitPopup(_ sender: Any) {
        self.removeAnimate()
    }
    
    @IBAction func gainsEntered(_ sender: Any) {
        
        
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
            }
        });
    }
}
