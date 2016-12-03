//
//  Config.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 12/3/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class Config {
    
    static let navigationBarColor:UIColor =  UIColor(red: 35.0/255.0, green: 220.0/255.0, blue: 147.0/255.0, alpha: 90.0/255.0)
    static let navigationBarTextColor: UIColor = UIColor(red: 15.0/255.0, green: 44.0/255.0, blue: 163.0/255.0, alpha: 150.0/255.0)
    
    private let fontType = "Chalkboard SE"
    
    static func getAppFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Chalkboard SE", size: size)!
    }
    
}
