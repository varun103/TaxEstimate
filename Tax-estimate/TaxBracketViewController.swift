//
//  TaxBracketViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/14/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class TaxBracketViewController: UIViewController {
    
    let screenTitle = "Tax Summary"
    
    var user:User?
    
    @IBOutlet weak var income: UILabel!
    
    @IBOutlet weak var preTaxDeductions: UILabel!
    @IBOutlet weak var capitalGains: UILabel!
    @IBOutlet weak var taxableIncome: UILabel!
    @IBOutlet weak var fedTax: UILabel!
    @IBOutlet weak var fedTaxBracket: UILabel!
    @IBOutlet weak var stateTax: UILabel!
    @IBOutlet weak var stateTaxBracket: UILabel!
    
    
    override func viewDidLoad() {
        
        self.navigationItem.title = self.screenTitle
        income.text = Config.addCommasToNumber(number: Int((user?.getIncome())!))
        preTaxDeductions.text = Config.addCommasToNumber(number: Int((user?.getPreTaxDeductions().getAmount())!))
        capitalGains.text = Config.addCommasToNumber(number: (user?.capitalGains.net)!)
        taxableIncome.text = Config.addCommasToNumber(number: Int((user?.getTaxableIncome())!))
        fedTax.text = Config.addCommasToNumber(number: (user?.getFederalTax())!)
        stateTax.text = Config.addCommasToNumber(number: (user?.getStateTax())!)
        fedTaxBracket.text = doubleToString(value: (user?.getFedTaxBracket().getRate())!) + "%"
        stateTaxBracket.text = doubleToString(value: (user?.getStateTaxBracket().getRate())!) + "%"
        
    }
    
    private func doubleToString(value:Double) -> String {
        return String(format:"%.2f",value)
    }
    
    
    
}
