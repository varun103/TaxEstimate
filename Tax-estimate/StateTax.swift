//
//  StateTax.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 5/1/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class StateTax: Tax {
    
    var state: TaxType
    
    init(income:Double, capitalGains:CapitalGains, status:FilingStatusEnum , state: TaxType) {
        self.state = state
        super.init(income: income, capitalGains: capitalGains, status: status)
    }
    
    /// - Returns: Bracket Info
    override func getBracket() -> Bracket {
        self.bracket = self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.taxableIncome)
        return self.bracket
    }
    
    override func reCalculate() {
        var amount:Int = 0
        for preTaxD in self.preTaxDeductions.all {
            amount = amount + preTaxD.getContributionAmount()
        }
        self.preTaxDeductionAmount = amount
        if (self.preTaxDeductionAmount > Int(self.income)) {
            
        }
        self.taxableIncome = self.income - Double(self.preTaxDeductionAmount)
        calculateTax()
    }
        
    private func calculateTax(){
        self.bracket = self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.taxableIncome)
    }

}
