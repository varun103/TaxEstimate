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
    @IBOutlet weak var contributionAmount: UILabel!
    @IBOutlet weak var overallIncomeAmount: UILabel!
    @IBOutlet weak var takeHomeIncomeAmount: UILabel!
    
    @IBAction func contributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.contribution401.text = "\(currentValue)"
        calculateTaxSavings(amount: currentValue)
    }
    
    var user: User?
    
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        
        self.fedTaxAmount.text = Config.addCommasToNumber(number: (user?.getFederalTax())!)
        self.stateTaxAmount.text = Config.addCommasToNumber(number: (user?.getStateTax())!)
        self.takeHomeIncome.text = Config.addCommasToNumber(number: (user?.getTakeHomeIncome())!)

    }
    
    private func calculateTaxSavings(amount: Int){
        
        user?.setContributionAmount(newContributionAmout: amount)
        //viewDidLoad()
        //self.taxSavings.text = "\(Double(amount) * (user?.getFedTaxBracket().getPercentage())!)"
        self.taxSavings.text =   Config.addCommasToNumber(number: (user?.getTaxSavings())!)
    
 }
}
