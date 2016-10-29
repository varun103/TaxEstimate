//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class TaxBracket{
    
    let bracket: Int;
    
    var startRange: Double;
    
    var endRange: Double?;
    
    var percentage: Double;
    
    
    init(bracket:Int, startRange:Double, endRange:Double?){
        self.bracket = bracket
        self.startRange = startRange
        self.endRange = endRange
        self.percentage = TaxBracket.calcBracket(self.bracket)
    }
    
    func getTax(income: Double) throws -> Double {
        if income >= self.endRange{
            throw TaxCalculationError.OutOfTaxBracket
        } else{
            return income * self.percentage
        }
    }
    
    func getTaxForFullRange() -> Double {
        if self.endRange != nil{
            return (self.endRange! - self.startRange) * self.percentage
        }else
        {
            return 0.0
        }
    }
    
    static func calcBracket(_bracket:Int) -> Double{
        return Double(_bracket) * 0.01
    }
    
}