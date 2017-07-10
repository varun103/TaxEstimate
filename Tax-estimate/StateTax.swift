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
    
    init(income:Double, capitalGains:CapitalGains, status:FilingStatusEnum , state: TaxType, preTaxDeductions:PreTaxDeductions) {
        self.state = state
        super.init(income: income, capitalGains: capitalGains, status: status, preTaxDeductions: preTaxDeductions)
    }
    
    /// - Returns: Bracket Info
    override func getBracket() -> Bracket {
        return self.bracket
    }
    
    override func calculate() throws {
        try self.taxableIncome  = self.initialIncome - Double(getPreTaxDeduction()) + Double(self.capitalGains.net(status: status))
        if (self.taxableIncome < 0){
            self.taxableIncome = 0
        }
        self.bracket = self.taxInfo.getStateBrackets(self.state, filingStatus: self.status).findBracket(income: self.taxableIncome)
    }


}
