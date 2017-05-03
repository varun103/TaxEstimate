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
    
    // income before deductions
    var initialIncome: Double
    
    // income that is taxed
    var taxableIncome: Double
    
    var fedTaxBracket: Bracket
    
    var stateTaxBracket: Bracket
    
//    var medicareTaxBracket: Bracket
//    
//    var socialSecurityTaxBracket: Bracket
    
    var taxInfo: TaxInfoService
    
    var state: TaxType
    
    var preTaxDeductionAmount: Int
    
    var preTaxDeductions: PreTaxDeductions
    
    init(filingStatus: FilingStatusEnum, income: Double, state: TaxType){
        self.status = filingStatus
        self.initialIncome = income
        self.state = state
        self.taxInfo = TaxInfoServiceImpl.getInstance()
        self.preTaxDeductionAmount = 0
        self.taxableIncome = self.initialIncome
        self.fedTaxBracket = User.setTaxBracket()
        self.stateTaxBracket = User.setTaxBracket()
        self.preTaxDeductions = PreTaxDeductionsImpl()
        calculateTax()
    }
    
    func getStatus() -> FilingStatusEnum{
        return self.status
    }
    
    func getIncome() -> Double{
        return self.initialIncome
    }
    
    func getTaxableIncome() -> Double {
        return self.taxableIncome
    }
    
    func getFedTaxBracket() -> Bracket{
        return self.fedTaxBracket
    }
    
    func getStateTaxBracket() -> Bracket{
        return self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.getTaxableIncome())
    }
    
    func getTakeHomeIncome() -> Int {
        return Int(self.initialIncome) - (self.getFederalTax() + self.getStateTax())
    }

    func getTakeHomeIncomeAfterOtherTaxes(){
        
    }
    
    func getFederalTax() -> Int {
        var _fedTax:Double = 0.0
        do {
            try _fedTax = getFedTaxBracket().getTax(getTaxableIncome())
        } catch {
            
        }
        return Int(_fedTax)
    }
    
    func getStateTax() -> Int {
        var _stateTax:Double = 0.0
        do {
            try _stateTax = getStateTaxBracket().getTax(getTaxableIncome())
        } catch {
            
        }
        return Int(_stateTax)
    }
    
    func getState() -> TaxType{
        return self.state
    }
    
    func getContributionAmount() -> Int{
        return self.preTaxDeductionAmount
    }
    
    func setContributionAmount(){

        var amount:Int = 0
        for preTaxD in self.preTaxDeductions.all {
            amount = amount + preTaxD.contributionAmount
        }
        self.preTaxDeductionAmount = amount
        self.taxableIncome = self.initialIncome - Double(self.preTaxDeductionAmount)
        calculateTax()
    }
    
    func getTaxSavings() -> Int {
        return getFedTaxSavings() + getStateTaxSavings()
    }
    
    func getFedTaxSavings() -> Int {
        return (Int((Double(self.preTaxDeductionAmount)) * self.getFedTaxBracket().getPercentage()))
    }
    
    func getStateTaxSavings() -> Int {
        return (Int((Double(self.preTaxDeductionAmount)) * self.getStateTaxBracket().getPercentage()))
    }
    
    func addPreTaxDeduction(deduction: PreTaxDeduction) {
        self.preTaxDeductions.add(preTaxDeduction: deduction)
        deduction.delegate = self
    }
    
    
    func deductionAmountChanged(_sender: PreTaxDeduction) {
        var amount:Int = 0
        for preTaxD in self.preTaxDeductions.all {
            amount = amount + preTaxD.getContributionAmount()
        }
        self.preTaxDeductionAmount = amount
        if (self.preTaxDeductionAmount > Int(self.initialIncome)) {
            
        }
        self.taxableIncome = self.initialIncome - Double(self.preTaxDeductionAmount)
        
        calculateTax()
    }

    static func setTaxBracket() -> Bracket {
        return Bracket(rate:0,startRange: 0,endRange: 0)
    }
    
    private func calculateTax(){
        self.fedTaxBracket = self.taxInfo.getFedBrackets(self.status).findBracket(income: self.taxableIncome)
        self.stateTaxBracket = self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.taxableIncome)

    }
    
}
