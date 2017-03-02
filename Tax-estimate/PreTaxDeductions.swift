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
    
}
