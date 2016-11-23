//
//  ViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/23/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiTaxLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var uiTaxField: UITextField!
    
    @IBAction func textEntered(_ sender: UITextField) {
        print(uiTaxField.text!)
    }
    
    var layer = CALayer()
    
    
    @IBAction func calculate(_ sender: UIButton) {
        let inputSalary = Double(uiTaxField.text!)
        let user: User = User(filingStatus: FilingStatusEnum.single, income: inputSalary!)
        uiTaxLabel.text = String(describing: user.getTaxBracket().getRate())
    }
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 35.0/255.0, green: 220.0/255.0, blue: 147.0/255.0, alpha: 90.0/255.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Chalkboard SE", size: 18) ?? UIFont.systemFont(ofSize: 17.0), NSForegroundColorAttributeName: UIColor(red: 15.0/255.0, green: 44.0/255.0, blue: 163.0/255.0, alpha: 100.0/255.0)]
        
        // Add shadow to the text box
        uiTaxField.layer.shadowColor = UIColor.gray.cgColor
        uiTaxField.layer.shadowRadius = 2.0
        uiTaxField.layer.shadowOffset = CGSize(width: 1, height: -1)
        uiTaxField.layer.masksToBounds = false
        uiTaxField.layer.shadowOpacity = 0.7

        // Round the text box
        uiTaxField.layer.cornerRadius = 15
        

        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 250.0/255.0, green: 253/255.0, blue: 254/255.0, alpha:50.0/255.0).cgColor, UIColor.clear.cgColor]
        gradient.cornerRadius = 15
        gradient.locations = [0.0 , 0.35]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
//        gradient.frame = CGRect(x: 1.0, y: 1.0, width: calculateButton.frame.size.width, height: calculateButton.frame.size.height)
        gradient.frame = calculateButton.bounds
        calculateButton.layer.insertSublayer(gradient, at: 1)

        
        calculateButton.layer.shadowColor = UIColor.gray.cgColor
        calculateButton.layer.shadowRadius = 2.0
        calculateButton.layer.masksToBounds = false
        calculateButton.layer.shadowOffset = CGSize(width: 2, height:2)

        calculateButton.layer.shadowOpacity = 0.7
        calculateButton.layer.cornerRadius = 15

//        calculateButton.titleLabel?.textColor = UIColor(colorLiteralRed: 98.0/255.0, green: 239.0/255.0, blue: 171.0/255.0, alpha: 100.0/255.0)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func testFieldShouldReturn(_ textField :UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func printTextField(){
        print(uiTaxField.text!)
    }
}

