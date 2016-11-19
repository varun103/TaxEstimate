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
    
    init(filingStatus: FilingStatusEnum, income: Double){
        self.status = filingStatus
        self.income = income
        self.taxBracket = User.setTaxBracket()
        self.taxInfo = TaxInfoServiceImpl()
    }
    
    func getStatus() -> FilingStatusEnum{
        return self.status
    }
    
    func getIncome() -> Double{
        return self.income
    }
    
    func getTaxBracket() -> TaxBrackets{
        return self.taxInfo.getFedBrackets(self.status)
    }
    
    func getFederalTax() -> Double {
        return 0.0
    }
    
    func getStateTax() -> Double {
        return 0.0
    }
    
    static func setTaxBracket() -> Bracket {
        return Bracket(rate:0,startRange: 0,endRange: 0)
    }
}
