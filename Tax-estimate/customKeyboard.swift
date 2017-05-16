//
//  customKeyboard.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 5/15/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit


class CustomKeyboard {
    
    static func keyboardWDoneButton(view:UIView) -> UIToolbar {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        return keyboardToolbar
    }
    
}
