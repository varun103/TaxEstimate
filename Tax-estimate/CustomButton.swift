//
//  CustomButton.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/13/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeEdgesCircular()
        addShadowToCircularButton()
        addGradientToCircularButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient.frame = bounds
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
    }

    private func makeEdgesCircular(){
        layer.cornerRadius = CGFloat(18.0)
        clipsToBounds = true
    }
    
    private func addShadowToCircularButton(){
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.9
        layer.frame = bounds
    }

    private func addGradientToCircularButton(){
        self.gradient.frame = bounds
        self.gradient.cornerRadius = 15
        self.gradient.colors = [UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha:80.0/255.0).cgColor, UIColor.clear.cgColor]
        self.gradient.locations = [0.0 , 1.0]
        self.gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
        self.gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradient, at: 0)
    }

}
