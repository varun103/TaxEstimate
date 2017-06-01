//
//  ViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/23/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class TaxInputController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, CapitalGainsDelegate {
    
    private let placeHolderText: String = "Enter your 2016 Income"
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var filingStatusPicker: UIPickerView!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var uiTaxField: UITextField!
    @IBOutlet weak var capitalGainsDisplay: UILabel!
    @IBOutlet weak var capitalGainsButton: UIButton!
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let innerShadow: CAGradientLayer = CAGradientLayer()
    
    private var layer = CALayer()
    private var userIncomeEntered: Bool = false
    private var user:User?
    private var filingStatusValues = FilingStatusEnum.allValues()
    private var selectedFilingStatus: String?
    private var stateValue = TaxType.states
    private var selectedState: String?
    private var capitalGains = CapitalGains(shortTerm: 0, longTerm: 0)
    
    var selectedApp:AppName?

    @IBAction func calculate(_ sender: UIButton) {
        if let inputValue = uiTaxField.text {
            if let inputSalary = Double(inputValue) {
                self.userIncomeEntered = true
                let inc = self.filingStatusPicker.selectedRow(inComponent: 0)
                let abc = self.statePicker.selectedRow(inComponent: 0)
                self.user = User(filingStatus: FilingStatusEnum(rawValue: filingStatusValues[inc])!, income: inputSalary, state: TaxType(rawValue: stateValue[abc])!, capitalGains: self.capitalGains)
            } else{
                self.userIncomeEntered = false
                showAlert()
            }
        } else{
            self.userIncomeEntered = false
            showAlert()
        }
        if self.userIncomeEntered {
            if selectedApp == AppName.preTaxDeductionCalculator {
                performSegue(withIdentifier: "preTaxDeductions", sender: self)
            } else if selectedApp == AppName.taxBracket {
                performSegue(withIdentifier: "taxBrackets", sender: self)
            }
        }
    }
    
    @IBAction func textEntered(_ sender: UITextField) {
    }
    
    override func viewDidLoad() {
        enhanceTextField()
        addGradientToButton()
        
        super.viewDidLoad()
        
        self.filingStatusPicker.dataSource = self
        self.filingStatusPicker.delegate = self
        
        self.filingStatusPicker.selectRow(0, inComponent: 0, animated: true)
        
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
        self.statePicker.selectRow(0, inComponent: 0, animated: true)
        
        self.capitalGains.delegate = self
        self.uiTaxField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        label!.font = Config.getMediumAppFont(size: 17.0)
        //label!.textColor = UIColor(red: 60.0/255.0, green: 88.0/255.0, blue: 199.0/255.0, alpha: 100.0)
        label!.textColor = UIColor(red: 44.0/255.0, green: 56.0/255.0, blue: 147.0/255.0, alpha: 100.0)

        label!.adjustsFontSizeToFitWidth = true
        label!.minimumScaleFactor = 0.5
        if (pickerView.tag == 1)  {
            label!.text = filingStatusValues[row]
        }else if(pickerView.tag == 2){
            label!.text = stateValue[row]
        }
        return label!
    }
    
    
    @IBAction func addCapitalGains(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cgPopupView") as! CGPopupViewController
        popUpVC.capitalGains = self.capitalGains
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    private func enhanceNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = Config.navigationBarColor
        self.navigationController?.navigationBar.tintColor = Config.navigationBarTextColor;
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: Config.getMediumAppFont(size: 18.0) , NSForegroundColorAttributeName: Config.navigationBarTextColor]
    }
    
    
    // This needed to be added since the gradients
    // were not covering the complete view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.gradient.frame = self.calculateButton.bounds
        self.innerShadow.frame = self.calculateButton.bounds
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    // Textfield func for the touch on BG
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "preTaxDeductions"{
            
            if let resultsPage = segue.destination as? ResultsViewController{
                resultsPage.user = self.user
            }
        } else if segue.identifier == "taxBrackets" {
            if let resultsPage = segue.destination as? TaxBracketViewController {
                resultsPage.user = self.user
            }
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.userIncomeEntered
    }
    
    
    // capital gains delegate
    func amountChanged() {
        self.capitalGainsDisplay.text = Config.addCommasToNumber(number: self.capitalGains.shortTermGains + self.capitalGains.longTermGains)
    }
    
    
    private func enhanceTextField(){
        
        self.uiTaxField.inputAccessoryView = CustomKeyboard.keyboardWDoneButton(view: self.view)
        self.innerShadow.colors = [UIColor.gray.cgColor, UIColor(red: 240.0/255.0, green: 235/255.0, blue: 235/255.0, alpha:50.0/255.0).cgColor]
        self.innerShadow.cornerRadius = 5
        self.innerShadow.locations = [0.0 , 0.05]
        self.innerShadow.startPoint = CGPoint(x: 0.5, y: 0.0)
        self.innerShadow.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.innerShadow.frame = self.uiTaxField.bounds
        self.uiTaxField.layer.addSublayer(self.innerShadow)
        
        // Round the edges on the text box
        self.uiTaxField.layer.cornerRadius = 15
        
        self.uiTaxField.attributedPlaceholder = NSAttributedString(string:placeHolderText, attributes:[NSFontAttributeName : Config.getMediumAppFont(size: 15.0)])
        self.uiTaxField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
    }
    
    
    private func addGradientToButton(){
        gradient.colors = [UIColor(red: 255.0/255.0, green: 255/255.0, blue: 255/255.0, alpha:180.0/255.0).cgColor, UIColor.clear.cgColor]
        gradient.cornerRadius = 15
        gradient.frame = self.calculateButton.bounds
        self.calculateButton.layer.insertSublayer(gradient, at: 0)
        self.calculateButton.layer.shadowOffset = CGSize(width: 2, height:-3)
        self.calculateButton.layer.cornerRadius = 15
        
    }
    
    private func showAlert() {
        let alert = CustomAlert.create(title:"", message: "Enter your income")
        self.present(alert, animated: true, completion: nil)
    }
    
    override var shouldAutorotate: Bool {
        get{
            return true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return UIInterfaceOrientationMask.portrait
        }
    }
    
}

