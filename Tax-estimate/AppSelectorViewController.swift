//
//  AppSelectorViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 2/8/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class AppSelectorViewController: UIViewController {
    
    
    @IBOutlet weak var taxSavings401KButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        taxSavings401KButton.layer.cornerRadius = 0.5 * taxSavings401KButton.bounds.size.width
        taxSavings401KButton.clipsToBounds = true
    }
}
