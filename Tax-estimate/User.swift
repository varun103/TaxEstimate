//
//  User.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class User : UserProtocol, DeductionDelegate {
    
    private(set)var status: FilingStatusEnum
    private(set)var initialIncome: Double
    private(set)var state: TaxType
    private(set)var capitalGains:CapitalGains
    private(set)var preTaxDeductions = PreTaxDeductionsImpl()

    var fedTax: Tax
    var stateTax: Tax
    
    init(filingStatus: FilingStatusEnum, income: Double, state: TaxType, capitalGains: CapitalGains) {
        self.status = filingStatus
        self.initialIncome = income
        self.state = state
        self.capitalGains = capitalGains
        self.fedTax = FedTax(income: income, capitalGains: capitalGains, status: filingStatus, preTaxDeductions:self.preTaxDeductions)
        self.stateTax = StateTax(income: income, capitalGains: capitalGains, status: filingStatus, state: state, preTaxDeductions: self.preTaxDeductions)
    }
    
    convenience init(filingStatus: FilingStatusEnum, income: Double, state: TaxType) {
       self.init(filingStatus: filingStatus, income: income, state: state, capitalGains: CapitalGains())
    }
    
    func getTaxableIncome() -> Double {
        return self.fedTax.totalTaxableIncome
    }
        
    func getTakeHomeIncome() -> Int {
        return Int(self.initialIncome) - (self.getFederalTax() + self.getStateTax())
    }
    
    func getFederalTax() -> Int {
        return self.fedTax.getTax()
    }
    
    func getStateTax() -> Int {
        return self.stateTax.getTax()
    }
    
    func getTaxSavings() -> Int {
        return getFedTaxSavings() + getStateTaxSavings()
    }
    
    func getFedTaxSavings() -> Int {
        return self.fedTax.getTaxSavings()
    }
    
    func getStateTaxSavings() -> Int {
        return self.stateTax.getTaxSavings()
    }
        
    func addPreTaxDeduction(deduction: PreTaxDeduction) {
        self.preTaxDeductions.add(preTaxDeduction: deduction)
        self.fedTax.addPreTaxDeduction(deduction: deduction)
        self.stateTax.addPreTaxDeduction(deduction: deduction)
        deduction.delegate = self
    }
    
    func deductionAmountChanged(_sender: PreTaxDeduction) throws {
        do {
            try fedTax.calculate()
            try stateTax.calculate()
            }
        catch  {
            throw UserInputError.deductionAmountExceedError
        }
    }

    static func setTaxBracket() -> Bracket {
        return Bracket(rate:0,startRange: 0,endRange: 0)
    }
    
}
