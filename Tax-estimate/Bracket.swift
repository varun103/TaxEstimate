//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}


class Bracket{
    
    fileprivate let bracket: Double
    
    fileprivate var startRange: Double?
    
    fileprivate var endRange: Double?
    
    fileprivate var percentage: Double
    
    
    init(bracket:Double, startRange:Double?, endRange:Double?){
        self.bracket = bracket
        self.startRange = startRange
        self.endRange = endRange
        self.percentage = Bracket.calcBracket(self.bracket)
    }
    
    func getTax(_ income: Double) throws -> Double {
        if income >= self.endRange{
            throw TaxCalculationError.outOfTaxBracket
        } else{
            return income * self.percentage
        }
    }
    
    func getTaxForFullRange() -> Double {
        if self.endRange != nil{
            return (self.endRange! - self.startRange!) * self.percentage
        }else
        {
            return 0.0
        }
    }
    
    func getMax() -> Double?{
        return self.endRange
    }
    
    func getMin()-> Double{
        return self.startRange!
    }
    
    func value()-> Double{
        return self.bracket
    }
        
    static func calcBracket(_ _bracket:Double) -> Double{
        return Double(_bracket) * 0.01
    }
    
}
