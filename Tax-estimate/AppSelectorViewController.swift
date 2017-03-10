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

    let gradient: CAGradientLayer = CAGradientLayer()
    let gradient_2: CAGradientLayer = CAGradientLayer()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeEdgesCircular(button: self.taxSavings401KButton, cornerRadius: 15)
        makeEdgesCircular(button: self.comingSoonButton, cornerRadius: 15)

        
        addGradientToCircularButton(button: self.taxSavings401KButton)
        addGradientToSmallerCircularButton(button: self.comingSoonButton)
        
        addShadowToCircularButton(button: self.taxSavings401KButton)
        addShadowToCircularButton(button: self.comingSoonButton)
        
        self.taxSavings401KButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.taxSavings401KButton.titleLabel?.minimumScaleFactor = 0.5
        enhanceNavigationBar()

    }
    
    private func enhanceNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = Config.navigationBarColor
        self.navigationController?.navigationBar.tintColor = Config.navigationBarTextColor;
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: Config.getMediumAppFont(size: 20.0) , NSForegroundColorAttributeName: Config.navigationBarTextColor]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidLayoutSubviews() {
        self.gradient.frame = self.taxSavings401KButton.bounds
        self.gradient_2.frame = self.comingSoonButton.bounds
    }
    
    private func addGradientToButton(){
        addGradientToCircularButton(button: self.taxSavings401KButton)
        addGradientToCircularButton(button: self.comingSoonButton)
    }
    
    private func makeEdgesCircular(button:UIButton, cornerRadius:Float){
        button.layer.cornerRadius = CGFloat(cornerRadius)
        button.clipsToBounds = true
    }
    
    private func makeButtonCircular(button:UIButton){
        let radius:Float = Float(0.5) * Float(button.bounds.size.width)
        makeEdgesCircular(button: button, cornerRadius: radius)
    }
    
    
    private func addGradientToCircularButton(button:UIButton){
        self.gradient.frame = button.bounds
        self.gradient.cornerRadius = 15
        self.gradient.colors = [UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha:120.0/255.0).cgColor, UIColor.clear.cgColor]
        self.gradient.locations = [0.0 , 1.0]
        self.gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
        self.gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        button.layer.insertSublayer(gradient, at: 0)
    }
    
    private func addGradientToSmallerCircularButton(button:UIButton){
        self.gradient_2.frame = button.bounds
        self.gradient_2.cornerRadius = 15
        self.gradient_2.colors = [UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha:120.0/255.0).cgColor, UIColor.clear.cgColor]
        self.gradient_2.locations = [0.0 , 1.0]
        self.gradient_2.startPoint = CGPoint(x: 0.5, y: 0.1)
        self.gradient_2.endPoint = CGPoint(x: 0.5, y: 1.0)
        button.layer.insertSublayer(self.gradient_2, at: 0)
    }
    
    private func addShadowToCircularButton(button:UIButton){
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 3)
        button.layer.masksToBounds = false
        button.layer.shadowOpacity = 0.9
        button.layer.frame = button.bounds
    }

}

extension UINavigationController {
    override open var shouldAutorotate: Bool {
        get{
            return false
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return UIInterfaceOrientationMask.portrait
        }
    }
}

