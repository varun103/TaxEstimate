//
//  File.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 6/1/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class CustomAlert {
    
    static func create(title:String, message:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        return alert
    }
    
    static func create(message:String) -> UIAlertController {
        return CustomAlert.create(title:"Error",message:message)
    }
    
    
}
