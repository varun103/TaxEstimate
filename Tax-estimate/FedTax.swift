//
//  FedTax.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/28/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class FedTax: Tax {
    
    var annualGrossIncome: Double
    var income: Double
    var capitalGains: CapitalGains
    var bracket: Bracket?
    var status: FilingStatusEnum?
    var taxInfo: TaxInfoService = TaxInfoServiceImpl.getInstance()
    
    init(income:Double, agi:Double, capitalGains:CapitalGains ) {
        self.income = income
        self.annualGrossIncome = agi
        self.capitalGains = capitalGains
    }
    
    func getBracket(){
        self.bracket = self.taxInfo.getFedBrackets(self.status!).findBracket(income: self.income)
    }
    
    
    
//    func getFederalTax() -> Int {
//        var _fedTax:Double = 0.0
//        do {
//            try _fedTax = getBracket().getTax(getTaxableIncome())
//        } catch {
//            
//        }
//        return Int(_fedTax)
//    }

}
