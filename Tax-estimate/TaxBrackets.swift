//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class TaxBrackets: TaxBracketsProtocol{
    
    private let income: Float
    private var federal_tax: Float
    
    private var taxBrackets = [FilingStatusEnum: [TaxBracket]]()
    
    
    init(income:Float){
        self.income = income
        self.federal_tax = 0.0
        initializeTaxBracketMap()
    }
    
    
    func getTaxBracketForUser(user: UserProtocol) -> TaxBracket? {
        return nil
    }
    
    private func initializeTaxBracketMap(){
        var readlinesArray :[String] = []
        
        do {
            let readlines =  try Utility.readFile("tax", type:"txt")
            readlinesArray = Utility.splitString(readlines, separator: "\n")
        } catch{
            
        }
        
        for line in readlinesArray{
            print(line)
        }
    }
    
}
