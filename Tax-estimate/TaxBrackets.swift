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
    
    private let fed_tax_file = "tax"
    private let file_type = "txt"
    
    
    private var taxBrackets = [FilingStatusEnum: [Bracket]]()
    
    
    init(income:Float){
        self.income = income
        self.federal_tax = 0.0
        initializeTaxBracketMap()
    }
    
    
    func getTaxBracketForUser(user: UserProtocol) -> Bracket? {
        return nil
    }
    
    private func initializeTaxBracketMap(){
        var readlinesArray :[String] = []
        
        do {
            let readlines =  try Utility.readFile(fed_tax_file, type:file_type)
            readlinesArray = Utility.splitString(readlines, separator: "\n")
            
            
            for line in readlinesArray {
                var elements = Utility.splitString(line, separator: ",")
                let rate = elements[BracketEnum.Rate.rawValue]
                
                let single_start_range = elements[BracketEnum.Single_start.rawValue]
                let single_end_range = elements[BracketEnum.Single_end.rawValue]
                
                
                
                //fed_bracket = TaxBracket(bracket: <#T##Int#>, startRange: <#T##Double#>, endRange: <#T##Double?#>)
            }
        } catch{
            
        }
        
        for line in readlinesArray{
            print(line)
        }
    }
    
}
