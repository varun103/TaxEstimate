//
//  UserProtocol.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


protocol UserProtocol {
    
    var initialIncome: Double {set get}
    
    var taxableIncome: Double {get set}

    var status: FilingStatusEnum {get}
    
    var preTaxDeductions: PreTaxDeductions {get}
    
    
    func getFederalTax() -> Int
    
    func getStateTax() -> Int
    
    func addPreTaxDeduction(deduction:PreTaxDeduction)
}
