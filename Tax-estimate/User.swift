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
    
    init(filingStatus: FilingStatusEnum, income: Double){
        self.status = filingStatus
        self.income = income
        self.taxBracket = User.setTaxBracket()
    }
    
    func getStatus() -> FilingStatusEnum{
        return self.status
    }
    
    func getIncome() -> Double{
        return self.income
    }
    
    func getTaxBracket() -> Bracket{
        return self.taxBracket
    }
    
    static func setTaxBracket() -> Bracket {
        return Bracket(bracket:0,startRange: 0,endRange: 0)
    }
}
