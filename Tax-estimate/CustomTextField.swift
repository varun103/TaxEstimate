//
//  CustomTextField.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 5/14/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    let innerShadow: CAGradientLayer = CAGradientLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 15.0
        
        self.innerShadow.colors = [UIColor.gray.cgColor, UIColor(red: 240.0/255.0, green: 235/255.0, blue: 235/255.0, alpha:50.0/255.0).cgColor]
        self.innerShadow.cornerRadius = 15
        self.innerShadow.locations = [0.0 , 0.05]
        self.innerShadow.startPoint = CGPoint(x: 0.5, y: 0.0)
        self.innerShadow.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.innerShadow.frame = self.bounds
        self.layer.addSublayer(self.innerShadow)
    
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom

    }
    
}
