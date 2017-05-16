//
//  User.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class User : UserProtocol, DeductionDelegate {
    
    var status: FilingStatusEnum
    
    var initialIncome: Double
    
    var fedTax: Tax
    var stateTax: Tax
    var state: TaxType
    
    var capitalGains:CapitalGains
    
    
    init(filingStatus: FilingStatusEnum, income: Double, state: TaxType, capitalGains: CapitalGains) {
        self.status = filingStatus
        self.initialIncome = income
        self.state = state
        self.capitalGains = capitalGains
        self.fedTax = FedTax(income: income, capitalGains: capitalGains, status: filingStatus)
        self.stateTax = StateTax(income: income, capitalGains: capitalGains, status: filingStatus, state: state)
    }
    
    convenience init(filingStatus: FilingStatusEnum, income: Double, state: TaxType) {
       self.init(filingStatus: filingStatus, income: income, state: state, capitalGains: CapitalGains())
    }
    
    func getStatus() -> FilingStatusEnum{
        return self.status
    }
    
    func getIncome() -> Double{
        return self.initialIncome
    }
    
    func getCapitalGains() -> CapitalGains {
        return self.capitalGains
    }
    
    func getTaxableIncome() -> Double {
        return self.fedTax.totalTaxableIncome
    }
    
    func getFedTaxBracket() -> Bracket {
        return self.fedTax.getBracket()
    }
    
    func getStateTaxBracket() -> Bracket{
        return self.stateTax.getBracket()
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
    
    func getState() -> TaxType{
        return self.state
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
