//
//  User.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class User : UserProtocol {
    
    var status: FilingStatus
    
    var income: Double
    
    var taxBracket: TaxBracket
    
    init(filingStatus: FilingStatus, income: Double){
        self.status = filingStatus
        self.income = income
        self.taxBracket = User.setTaxBracket()
    }
    
    func getStatus() -> FilingStatus{
        return self.status
    }
    
    func getIncome() -> Double{
        return self.income
    }
    
    func getTaxBracket() -> TaxBracket{
        return self.taxBracket
    }
    
    static func setTaxBracket() -> TaxBracket {
        return TaxBracket(bracket:0,startRange: 0,endRange: 0)
    }
}
