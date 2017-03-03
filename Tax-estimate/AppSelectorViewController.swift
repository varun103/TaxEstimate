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

        makeButtonCircular(button: self.taxSavings401KButton)
        makeButtonCircular(button: self.comingSoonButton)
        
        addGradientToCircularButton(button: self.taxSavings401KButton)
//        addGradientToCircularButton(button: self.comingSoonButton)
        
        addShadowToCircularButton(button: self.taxSavings401KButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    private func addGradientToButton(){
        addGradientToCircularButton(button: self.taxSavings401KButton)
        addGradientToCircularButton(button: self.comingSoonButton)
    }
    
    
    private func makeButtonCircular(button:UIButton){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
    }
    
    
    private func addGradientToCircularButton(button:UIButton){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = button.bounds
        gradient.cornerRadius = 0.5 * button.bounds.size.width
        gradient.colors = [UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha:180.0/255.0).cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        button.layer.insertSublayer(gradient, at: 0)
    }
    
    private func addShadowToCircularButton(button:UIButton){
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 3)
        button.layer.masksToBounds = false
        button.layer.shadowOpacity = 0.9
    }
}
