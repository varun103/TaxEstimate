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
    
    fileprivate let rate: Double
    
    fileprivate var startRange: Double
    
    fileprivate var endRange: Double?
    
    fileprivate var percentage: Double
    
    private var taxForBracket: Double?

    private var totalTaxIncPreviousBrackets: Double?
    
    var next: Bracket?
    var previous: Bracket?
    
    
    init(rate:Double, startRange:Double, endRange:Double?){
        self.rate = rate
        self.startRange = startRange
        self.endRange = endRange
        self.percentage = Bracket.calcBracket(self.rate)
        self.setTaxForBracket()
    }
    
    func getTax(_ income: Double) throws -> Double {
        return ((income - self.startRange) * self.percentage + self.getTotalTaxForPreviousBrackets())
    }
        
    func getMax() -> Double?{
        return self.endRange
    }
    
    func getMin()-> Double{
        return self.startRange
    }
    
    func getRate()-> Double{
        return self.rate
    }
    
    func value()-> Double{
        return self.rate
    }
    
    func taxForFullRange()-> Double {
        return self.taxForBracket!
    }
    
    func totalTaxWPreviousBrackets()-> Double {
        return self.totalTaxIncPreviousBrackets!
    }
    
    func setNext(nextBracket: Bracket?){
        self.next = nextBracket
    }
    
    func hasNext()-> Bool{
        return self.next != nil
        
    }
    
    func getTotalTaxForPreviousBrackets()-> Double {
        var _prevTax: Double = 0.0
        if let _prev = self.previous {
           _prevTax  = _prev.totalTaxWPreviousBrackets()
        }
        return _prevTax
    }
    
    func setPrevious(previousBracket:Bracket?){
        self.previous = previousBracket
        self.setTotalTaxIncPreviousBrackets()
    }
    
    private func setTaxForBracket() {
        if let _max = self.endRange {
            self.taxForBracket = (_max - self.startRange) * self.percentage
        } else {
            self.taxForBracket = 0.0
        }
    }
    
    private func setTotalTaxIncPreviousBrackets() {
        if let _prev = self.previous {
            self.totalTaxIncPreviousBrackets = _prev.totalTaxWPreviousBrackets() + self.taxForFullRange()
        } else {
            self.totalTaxIncPreviousBrackets = self.taxForFullRange()
        }
    }
    
    static func calcBracket(_ _bracket:Double) -> Double{
        return Double(_bracket) * 0.01
    }
    
}
