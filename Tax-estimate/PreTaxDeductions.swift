//
//  PreTaxDeductions.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 2/27/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit


protocol PreTaxDeductions: Deductions {
    
    var all:[PreTaxDeduction] {get}
    
    func add(preTaxDeduction: PreTaxDeduction)
    
    func getAmount() -> Int
    
}

class PreTaxDeductionsImpl: PreTaxDeductions {
    
    init(){
        self.all = []
    }
    
    func add(preTaxDeduction: PreTaxDeduction) {
        self.all.append(preTaxDeduction)
    }

    var all:[PreTaxDeduction]
    
    
    func apply() -> Double {
        return 0
    }
    
    func getAmount() -> Int {
        
        var amount:Int = 0
        for preTaxD in self.all {
            amount = amount + preTaxD.getContributionAmount()
        }
        return amount
    }
    
}
