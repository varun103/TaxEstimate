//
//  User.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class User : UserProtocol {
    
    var status: FilingStatusEnum
    
    // income before deductions
    var initialIncome: Double
    
    // income that is taxed
    var taxableIncome: Double
    
    var taxBracket: Bracket
    var fedTaxBracket: Bracket
    var stateTaxBracket: Bracket
    
    var taxInfo: TaxInfoService
    
    var state: TaxType
    
    var contribution401K: Int
    
    init(filingStatus: FilingStatusEnum, income: Double, state: TaxType){
        self.status = filingStatus
        self.initialIncome = income
        self.state = state
        self.taxBracket = User.setTaxBracket()
        self.taxInfo = TaxInfoServiceImpl.getInstance()
        self.contribution401K = 0
        self.taxableIncome = self.initialIncome
        self.fedTaxBracket = taxBracket
        self.stateTaxBracket = taxBracket
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
        return self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.getIncome())
    }
    
    func getTakeHomeIncome() -> Int {
        return Int(self.initialIncome) - ( self.getFederalTax() + self.getStateTax())
    }

    func getTakeHomeIncomeAfterOtherTaxes(){
        
    }
    
    func getFederalTax() -> Int {
        var _fedTax:Double = 0.0
        do {
            try _fedTax = self.getFedTaxBracket().getTax(self.getTaxableIncome())
        } catch {
            
        }
        return Int(_fedTax)
    }
    
    func getStateTax() -> Int {
        var _stateTax:Double = 0.0
        do {
            try _stateTax = self.getStateTaxBracket().getTax(self.getTaxableIncome())
        } catch {
            
        }
        return Int(_stateTax)
    }
    
    func getState() -> TaxType{
        return self.state
    }
    
    func getContributionAmount() -> Int{
        return self.contribution401K
    }
    
    func setContributionAmount(newContributionAmout: Int){
        self.contribution401K = newContributionAmout
        self.taxableIncome = self.initialIncome - Double(self.contribution401K)
        calculateTax()
    }
    
    func getTaxSavings() -> Int {
        return (Int((Double(self.contribution401K)) * self.getFedTaxBracket().getPercentage()))
    }
    
    static func setTaxBracket() -> Bracket {
        return Bracket(rate:0,startRange: 0,endRange: 0)
    }
    
    private func calculateTax(){
        self.fedTaxBracket = self.taxInfo.getFedBrackets(self.status).findBracket(income: self.taxableIncome)
        self.stateTaxBracket = self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.taxableIncome)
    }
    
    public class Builder{
        
    }
}
