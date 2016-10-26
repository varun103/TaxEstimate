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
    
    @IBOutlet weak var uiTaxField: UITextField!
    
    @IBAction func textEntered(sender: UITextField) {
        print(uiTaxField.text)
    }
    @IBAction func calculate(sender: UIButton) {
        let inputSalary = Int(uiTaxField.text!)
        uiTaxLabel.text = String(inputSalary)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func testFieldShouldReturn(textField :UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func printTextField(){
        print(uiTaxField.text)
    }
}

