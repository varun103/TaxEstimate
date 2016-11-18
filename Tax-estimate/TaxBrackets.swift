//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class TaxBrackets: TaxBracketsProtocol{
    
    private let file_type = "txt"
    private let income: Float
    private var federal_tax: Float
    private var dependencies: Dependencies
    
    //core DS
    private var taxBrackets = [FilingStatusEnum: [TaxType: [Bracket]]]()
    
    
    init(income:Float, dependencies: Dependencies) {
        self.income = income
        self.federal_tax = 0.0
        self.dependencies = dependencies
        initializeTaxBracketMap()
    }
    
    convenience init(income:Float){
        self.init(income: income, dependencies: Dependencies())
    }
    
    convenience init(){
        self.init(income: 0.0, dependencies: Dependencies())
    }
    
    func getTaxBrackets() -> [FilingStatusEnum: [TaxType: [Bracket]]] {
        return self.taxBrackets
    }
    
    func forFed(filingStatus: FilingStatusEnum) -> [Bracket] {
        var abc = self.taxBrackets[filingStatus]!
        if let bc = abc[TaxType.FED] {
            return bc
        } else{
            
        }
    }
    
    func forState(taxType: TaxType, filingStatus: FilingStatusEnum) -> [Bracket] {
        var abc = self.taxBrackets[filingStatus]!
        if let bc = abc[taxType] {
            return bc
        } else{
            
        }
    }

    
    
    private func initializeTaxBracketMap(){
        
        var bracketInfoArray :[String] = []
        
        let taxTypes = self.dependencies.getTaxTypes()
        
        var singleMap:[TaxType:[Bracket]] = [:]
        var marriedMap:[TaxType:[Bracket]] = [:]
        var headMap:[TaxType:[Bracket]] = [:]
        
        do {
            
            for taxType in taxTypes {
                
                let bracketInfoFileName = taxType.rawValue
                let bracketInfoFileContents =  try Utility.readFile(bracketInfoFileName, type:file_type)
                
                // each line = element in array
                bracketInfoArray = Utility.splitString(bracketInfoFileContents, separator: "\n")
                
                var singleBrackets:[Bracket] = []
                var marriedBrackets:[Bracket] = []
                var headBrackets:[Bracket]=[]
                
                
                var count = 0
                for bracketInfo in bracketInfoArray {
                    if count == 0 {
                        count = count + 1
                        continue
                    }
                    var elements = Utility.splitString(bracketInfo, separator: ",")
                    let rate = Double(elements[BracketEnum.Rate.rawValue])
                    
                    let single_start = Double(elements[BracketEnum.Single_start.rawValue])
                    let single_end = Double(elements[BracketEnum.Single_end.rawValue])
                    singleBrackets.append(Bracket(bracket: rate, startRange: single_start, endRange: single_end))
                    
                    let married_start = Double(elements[BracketEnum.Married_start.rawValue])
                    let married_end = Double(elements[BracketEnum.Married_end.rawValue])
                    marriedBrackets.append(Bracket(bracket: rate, startRange: married_start, endRange: married_end))
                    
                    let head_start = Double(elements[BracketEnum.Head_start.rawValue])
                    let head_end = Double(elements[BracketEnum.Head_end.rawValue])
                    headBrackets.append(Bracket(bracket: rate!, startRange: head_start!, endRange: head_end))
                    
                    count = count + 1
                    
                }
                singleMap[taxType] = singleBrackets
                marriedMap[taxType] = marriedBrackets
                headMap[taxType] = headBrackets
            }
            
            self.taxBrackets[FilingStatusEnum.Single] = singleMap
            self.taxBrackets[FilingStatusEnum.Married] = marriedMap
            self.taxBrackets[FilingStatusEnum.Head] = headMap
            
        } catch {
            
        }
        
    }
    
    //static dependencies
    class Dependencies {
        
        func getTaxTypes() -> [TaxType]{
            return TaxType.all
        }
    }
    
}
