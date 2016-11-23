//
//  ViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/23/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var uiTaxLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var filingStatusPicker: UIPickerView!
    
    @IBOutlet weak var uiTaxField: UITextField!
    
    private var layer = CALayer()
    
    private var filingStatusValues = FilingStatusEnum.allValues()
    
    private var stateValue = TaxType.states
    
    @IBAction func textEntered(_ sender: UITextField) {
        print(uiTaxField.text!)
    }
    
    
    @IBAction func calculate(_ sender: UIButton) {
        let inputSalary = Double(uiTaxField.text!)
        let user: User = User(filingStatus: FilingStatusEnum.single, income: inputSalary!)
        uiTaxLabel.text = String(describing: user.getTaxBracket().getRate())
    }
    override func viewDidLoad() {
        enhanceNavigationBar()
        enhanceTextField()
        addGradientToButton()
        
        super.viewDidLoad()
        
        self.filingStatusPicker.dataSource = self
        self.filingStatusPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func testFieldShouldReturn(_ textField :UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filingStatusValues.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        label!.font = UIFont(name: "Chalkboard SE", size: 13.0)
        label!.text = filingStatusValues[row]
        return label!
    }
    
    
    private func enhanceNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 35.0/255.0, green: 220.0/255.0, blue: 147.0/255.0, alpha: 90.0/255.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Chalkboard SE", size: 18) ?? UIFont.systemFont(ofSize: 17.0), NSForegroundColorAttributeName: UIColor(red: 15.0/255.0, green: 44.0/255.0, blue: 163.0/255.0, alpha: 100.0/255.0)]
    }
    
    private func enhanceTextField(){
        // Add shadow to the text box
        self.uiTaxField.layer.shadowColor = UIColor.gray.cgColor
        self.uiTaxField.layer.shadowRadius = 2.0
        self.uiTaxField.layer.shadowOffset = CGSize(width: 1, height: -1)
        self.uiTaxField.layer.masksToBounds = false
        self.uiTaxField.layer.shadowOpacity = 0.7
        
        // Round the edges on the text box
        self.uiTaxField.layer.cornerRadius = 15
    }
    
    private func addGradientToButton(){
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 255.0/255.0, green: 253/255.0, blue: 254/255.0, alpha:50.0/255.0).cgColor, UIColor.clear.cgColor]
        gradient.cornerRadius = 15
        gradient.locations = [0.0 , 0.35]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = self.calculateButton.bounds
        
        self.calculateButton.layer.insertSublayer(gradient, at: 1)
        self.calculateButton.layer.shadowColor = UIColor.gray.cgColor
        self.calculateButton.layer.shadowRadius = 2.0
        self.calculateButton.layer.masksToBounds = false
        self.calculateButton.layer.shadowOffset = CGSize(width: 2, height:2)
        self.calculateButton.layer.shadowOpacity = 0.7
        self.calculateButton.layer.cornerRadius = 15
        
    }
    
    func printTextField(){
        print(uiTaxField.text!)
    }
}

