//
//  Tax.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/28/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class Tax {
    
    var income: Double
    var preTaxDeductions: PreTaxDeductions
    var taxableIncome: Double
    var status: FilingStatusEnum
    var preTaxDeductionAmount: Int
    var bracket: Bracket
    var capitalGains: CapitalGains
    var taxInfo: TaxInfoService = TaxInfoServiceImpl.getInstance()

    init(income: Double, capitalGains: CapitalGains, status: FilingStatusEnum){
        self.income = income
        self.taxableIncome = self.income
        self.status = status
        self.preTaxDeductionAmount = 0
        self.bracket = Tax.setTaxBracket()
        self.preTaxDeductions = PreTaxDeductionsImpl()
        self.capitalGains = capitalGains
    }
    
    func getBracket() -> Bracket{
        return self.bracket
    }
    
    /// - Returns: Taxble income
    func getTaxableIncome() -> Double {
        return self.taxableIncome
    }
    
    /// - Returns: the tax
    func getTax() -> Int {
        var _tax:Double = 0.0
        do {
            try _tax = self.getBracket().getTax(self.taxableIncome)
        } catch {
        }
        return Int(_tax)
    }
    
    func getTaxSavings() -> Int {
        return (Int((Double(self.preTaxDeductionAmount)) * self.getBracket().getPercentage()))
    }


    func addPreTaxDeduction(deduction: PreTaxDeduction) {
        self.preTaxDeductions.add(preTaxDeduction: deduction)
    }
    
    func reCalculate() throws {}
    
    func capitalGainsTax() {}
    
    static func setTaxBracket() -> Bracket {
        return Bracket(rate:0,startRange: 0,endRange: 0)
    }
}
