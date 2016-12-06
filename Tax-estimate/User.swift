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
    
    var income: Double
    
    var taxBracket: Bracket
    
    var taxInfo: TaxInfoService
    
    var state: TaxType
    
    init(filingStatus: FilingStatusEnum, income: Double, state: TaxType){
        self.status = filingStatus
        self.income = income
        self.state = state
        self.taxBracket = User.setTaxBracket()
        self.taxInfo = TaxInfoServiceImpl.getInstance()
    }
    
    func getStatus() -> FilingStatusEnum{
        return self.status
    }
    
    func getIncome() -> Double{
        return self.income
    }
    
    func getFedTaxBracket() -> Bracket{
        return self.taxInfo.getFedBrackets(self.status).findBracket(income: self.getIncome())
    }
    
    func getStateTaxBracket() -> Bracket{
        return self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.getIncome())
    }

    
    func getFederalTax() -> Double {
        var _fedTax:Double = 0.0
        do {
            try _fedTax = self.getFedTaxBracket().getTax(self.getIncome())
        } catch {
            
        }
        return _fedTax
    }
    
    func getStateTax() -> Double {
        var _fedTax:Double = 0.0
        do {
            try _fedTax = self.getStateTaxBracket().getTax(self.getIncome())
        } catch {
            
        }
        return _fedTax
    }
    
    func getState() -> TaxType{
        return self.state
    }
    
    static func setTaxBracket() -> Bracket {
        return Bracket(rate:0,startRange: 0,endRange: 0)
    }
}
