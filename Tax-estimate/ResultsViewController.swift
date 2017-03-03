//
//  ResultsViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/30/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {
    
    
    private final let textCellIdentifier = "resultCell"
    
    @IBOutlet weak var fedTax: UILabel!
    @IBOutlet weak var stateTax: UILabel!
    @IBOutlet weak var contribution401: UILabel!
    @IBOutlet weak var takeHomeIncome: UILabel!
    @IBOutlet weak var overallIncome: UILabel!
    @IBOutlet weak var taxSavings: UILabel!
    
    @IBOutlet weak var fedTaxAmount: UILabel!
    @IBOutlet weak var stateTaxAmount: UILabel!
    @IBOutlet weak var fourOOneKSlider: UISlider!
    @IBOutlet weak var fsaSlider: UISlider!
    @IBOutlet weak var contributionAmount: UILabel!

    @IBOutlet weak var fsaContributionAmount: UILabel!
    @IBOutlet weak var overallIncomeAmount: UILabel!
    
    private var fourOOneKPreTaxDeduction: FourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
    private var fsaPreTaxDeduction: FSAHealthPreTaxDeduction = FSAHealthPreTaxDeduction()
    
    @IBAction func fsaContributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.fsaContributionAmount.text = "\(currentValue)"
        self.fsaPreTaxDeduction.contributionAmount = currentValue
        calculateTaxSavings()
    }
    @IBAction func contributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.contribution401.text = "\(currentValue)"
        self.fourOOneKPreTaxDeduction.contributionAmount = currentValue
        calculateTaxSavings()
    }
    
    var user: User?
    
    @IBOutlet weak var result: UILabel!
    
    
    override func viewDidLoad() {
    
        self.navigationItem.title = "Pre-Tax Deductions"

        self.fedTaxAmount.text = Config.addCommasToNumber(number: (user?.getFederalTax())!)
        self.stateTaxAmount.text = Config.addCommasToNumber(number: (user?.getStateTax())!)
//        self.takeHomeIncome.text = Config.addCommasToNumber(number: (user?.getTakeHomeIncome())!)
//        
        
       // self.fourOOneKSlider.isContinuous = false
        
        user?.addPreTaxDeduction(deduction: fourOOneKPreTaxDeduction)
        user?.addPreTaxDeduction(deduction: fsaPreTaxDeduction)
    }
    
    private func calculateTaxSavings(){
        
        //user?.setContributionAmount()
        self.overallIncomeAmount.text =   Config.addCommasToNumber(number: (user?.getTaxSavings())!)
    }
}
