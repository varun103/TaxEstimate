//
//  AppSelectorViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 2/8/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class AppSelectorViewController: UIViewController {
    
    //UI Components
    @IBOutlet weak var taxSavings401KButton: UIButton!
    @IBOutlet weak var comingSoonButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        enhanceNavigationBar()
    }
    
    private func enhanceNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = Config.navigationBarColor
        self.navigationController?.navigationBar.tintColor = Config.navigationBarTextColor;
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: Config.getMediumAppFont(size: 18.0) , NSForegroundColorAttributeName: Config.navigationBarTextColor]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
}

enum AppNames{
    case preTaxDeductionCalculator
    case taxBracket
}


extension UINavigationController {
    override open var shouldAutorotate: Bool {
        get{
            return true
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return UIInterfaceOrientationMask.portrait
        }
    }
}

