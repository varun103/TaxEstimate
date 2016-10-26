//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class TaxBrackets {
    
    private let income: Float
    private var federal_tax: Float
    
    private var taxBrackets = [Float: Float]()
    
    init(income:Float){
        self.income = income
        self.federal_tax = 0.0
        initializeTaxBracketMap()
    }
    
    
    func getTaxBracket() -> Int {
    
        if self.income > taxBrackets[10]{
           self.federal_tax = self.federal_tax + (taxBrackets[10]! * 0.10)
        }
        return 0
    }
    
    
    func initializeTaxBracketMap(){
        taxBrackets[10]=9275
        taxBrackets[15]=37650
        taxBrackets[25]=91150
        taxBrackets[28]=190150
        taxBrackets[33]=413350
        taxBrackets[35]=415050
        taxBrackets[39.5]=0
    }
}
