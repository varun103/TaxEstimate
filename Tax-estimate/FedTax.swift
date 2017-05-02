//
//  FedTax.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/28/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class FedTax: Tax {
    
    
    /// - Returns: Bracket Info
    override func getBracket() -> Bracket {
        self.bracket = self.taxInfo.getFedBrackets(self.status).findBracket(income: self.taxableIncome)
        return self.bracket
    }
                
    override func reCalculate() throws {
        var amount:Int = 0
        for preTaxD in self.preTaxDeductions.all {
            amount = amount + preTaxD.getContributionAmount()
        }
        self.preTaxDeductionAmount = amount
        if (self.preTaxDeductionAmount > Int(self.income)) {
            throw UserInputError.deductionAmountExceedError
        }
        self.taxableIncome = self.income - Double(self.preTaxDeductionAmount)
        calculateTax()
    }
    
    
    override func capitalGainsTax() {
        
    }
    
    private func calculateTax(){
        self.bracket = self.taxInfo.getFedBrackets(self.status).findBracket(income: self.taxableIncome)
    }
    
}
