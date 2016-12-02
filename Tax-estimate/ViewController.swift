//
//  ViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/23/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var uiTaxLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var filingStatusPicker: UIPickerView!
    
    @IBOutlet weak var statePicker: UIPickerView!
    
    @IBOutlet weak var uiTaxField: UITextField!
    
    private var layer = CALayer()
    
    private var userIncomeEnterd: Bool = false
    
    private var user:User?
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let innerShadow: CAGradientLayer = CAGradientLayer()
    
    
    
    private var filingStatusValues = FilingStatusEnum.allValues()
    
    private var stateValue = TaxType.states
    
    @IBAction func textEntered(_ sender: UITextField) {
        print(uiTaxField.text!)
    }
    
    
    @IBAction func calculate(_ sender: UIButton) {
        if let inputValue = uiTaxField.text {
            if let inputSalary = Double(inputValue) {
                self.userIncomeEnterd = true
                self.user = User(filingStatus: FilingStatusEnum.single, income: inputSalary)
            }
        } else{
            //do nothing
        }
    }
    
    
    override func viewDidLoad() {
        enhanceNavigationBar()
        enhanceTextField()
        addGradientToButton()
        
        super.viewDidLoad()
        
        self.filingStatusPicker.dataSource = self
        self.filingStatusPicker.delegate = self
        
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
        
        
        self.uiTaxField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count: Int = 0
        if (pickerView.tag == 1){
            count =  filingStatusValues.count
        } else if(pickerView.tag == 2){
            count =  stateValue.count
        }
        return count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        label!.font = UIFont(name: "Chalkboard SE", size: 17.0)
        label!.textColor = UIColor(red: 60.0/255.0, green: 88.0/255.0, blue: 199.0/255.0, alpha: 100.0)
        if (pickerView.tag == 1)  {
            label!.text = filingStatusValues[row]
        }else if(pickerView.tag == 2){
            label!.text = stateValue[row]
        }
        return label!
    }
    
    
    private func enhanceNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 35.0/255.0, green: 220.0/255.0, blue: 147.0/255.0, alpha: 90.0/255.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Chalkboard SE", size: 18) ?? UIFont.systemFont(ofSize: 17.0), NSForegroundColorAttributeName: UIColor(red: 15.0/255.0, green: 44.0/255.0, blue: 163.0/255.0, alpha: 150.0/255.0)]
    }
    
    private func enhanceTextField(){
        self.innerShadow.colors = [UIColor.gray.cgColor, UIColor(red: 240.0/255.0, green: 235/255.0, blue: 235/255.0, alpha:50.0/255.0).cgColor]
        self.innerShadow.cornerRadius = 5
        self.innerShadow.locations = [0.0 , 0.05]
        self.innerShadow.startPoint = CGPoint(x: 0.5, y: 0.0)
        self.innerShadow.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.innerShadow.frame = self.calculateButton.bounds
        self.uiTaxField.layer.addSublayer(self.innerShadow)
        
        // Round the edges on the text box
        self.uiTaxField.layer.cornerRadius = 15
        
        self.uiTaxField.attributedPlaceholder = NSAttributedString(string:"Enter you taxable income", attributes:[NSFontAttributeName : UIFont(name: "Chalkboard SE", size: 16)])
        self.uiTaxField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
    }
    
    private func addGradientToButton(){
        
        gradient.colors = [UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha:180.0/255.0).cgColor, UIColor.clear.cgColor]
        gradient.cornerRadius = 15
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradient.frame = self.calculateButton.bounds
        self.calculateButton.layer.insertSublayer(gradient, at: 0)
        
        self.calculateButton.layer.shadowColor = UIColor.gray.cgColor
        self.calculateButton.layer.shadowRadius = 2.0
        self.calculateButton.layer.masksToBounds = false
        self.calculateButton.layer.shadowOffset = CGSize(width: 2, height:-3)
        self.calculateButton.layer.shadowOpacity = 0.7
        self.calculateButton.layer.cornerRadius = 15
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.gradient.frame = self.calculateButton.bounds
        self.innerShadow.frame = self.calculateButton.bounds
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    //textfield func for the touch on BG
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToResults"{
            
            if let resultsPage = segue.destination as? ResultsViewController{
                resultsPage.user = self.user
            }
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.userIncomeEnterd
    }
    
    func printTextField(){
        print(uiTaxField.text!)
    }
}

