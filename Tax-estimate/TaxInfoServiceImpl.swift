//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit
import Darwin

class TaxInfoServiceImpl: TaxInfoService{
    
    private let file_type = "txt"
    fileprivate let income: Float
    fileprivate var federal_tax: Float
    fileprivate var dependencies: Dependencies
    
    //core DS
    fileprivate var taxInfo = [FilingStatusEnum: [TaxType: TaxBrackets]]()
    
    
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
    
    func getCatalogue() -> [FilingStatusEnum: [TaxType: TaxBrackets]] {
        return self.taxInfo
    }
    
    func getFedBrackets(_ filingStatus: FilingStatusEnum) -> TaxBrackets {
        var abc = self.taxInfo[filingStatus]!
        if let bc = abc[TaxType.FED] {
            return bc
        } else{
            exit(0)
        }
    }
    
    func getStateBrackets(_ taxType: TaxType, filingStatus: FilingStatusEnum) -> TaxBrackets {
        var abc = self.taxInfo[filingStatus]!
        if let bc = abc[taxType] {
            return bc
        } else{
            exit(0)
        }
    }
    
    fileprivate func initializeTaxBracketMap(){
        
        var bracketInfoArray :[String] = []
        
        let taxTypes = self.dependencies.getTaxTypes()
        
        var singleMap:[TaxType:TaxBrackets] = [:]
        var marriedMap:[TaxType:TaxBrackets] = [:]
        var headMap:[TaxType:TaxBrackets] = [:]
        
        do {
            
            for taxType in taxTypes {
                
                let bracketInfoFileName = taxType.rawValue
                let bracketInfoFileContents =  try Utility.readFile(bracketInfoFileName, type:file_type)
                
                // each line = element in array
                bracketInfoArray = Utility.splitString(bracketInfoFileContents, separator: "\n")
                
                let singleBrackets: TaxBrackets = TaxBrackets()
                let marriedBrackets: TaxBrackets = TaxBrackets()
                let headBrackets: TaxBrackets =  TaxBrackets()
                
                
                var count = 0
                for bracketInfo in bracketInfoArray {
                    if count == 0 {
                        count = count + 1
                        continue
                    }
                    var elements = Utility.splitString(bracketInfo, separator: ",")
                    let rate = Double(elements[BracketEnum.rate.rawValue])
                    
                    let single_start = Double(elements[BracketEnum.single_start.rawValue])
                    let single_end = Double(elements[BracketEnum.single_end.rawValue])
                    singleBrackets.add(bracket: Bracket(bracket: rate!, startRange: single_start, endRange: single_end))
                    
                    let married_start = Double(elements[BracketEnum.married_start.rawValue])
                    let married_end = Double(elements[BracketEnum.married_end.rawValue])
                    marriedBrackets.add(bracket: Bracket(bracket: rate!, startRange: married_start, endRange: married_end))
                    
                    let head_start = Double(elements[BracketEnum.head_start.rawValue])
                    let head_end = Double(elements[BracketEnum.head_end.rawValue])
                    headBrackets.add(bracket: Bracket(bracket: rate!, startRange: head_start!, endRange: head_end))
                    
                    count = count + 1
                    
                }
                singleMap[taxType] = singleBrackets
                marriedMap[taxType] = marriedBrackets
                headMap[taxType] = headBrackets
            }
            
            self.taxInfo[FilingStatusEnum.single] = singleMap
            self.taxInfo[FilingStatusEnum.married] = marriedMap
            self.taxInfo[FilingStatusEnum.head] = headMap
            
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
