//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit
import Darwin

class TaxInfoServiceImpl: TaxInfoService {
    
    private let file_type = "csv"
    private var dependencies: Dependencies
    private static var taxInfoServiceImpl:TaxInfoServiceImpl?

    //core DS
    private var taxInfo = [FilingStatusEnum: [TaxType: TaxBrackets]]()
    
    static func getInstance()->TaxInfoServiceImpl{
        if let _instance = taxInfoServiceImpl {
            return _instance
        }else{
            taxInfoServiceImpl = TaxInfoServiceImpl()
            return taxInfoServiceImpl!
        }
    }
    
    private init() {
        self.dependencies = Dependencies()
        do {
        try initializeTaxBracketMap()
        } catch {
            print("Could not initialize the Tax Catalogue")
        }
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
    
    func getLongTermGainsTaxBracket(filingStatus: FilingStatusEnum) -> TaxBrackets {
        var abc = self.taxInfo[filingStatus]!
        if let bc = abc[TaxType.LONG_TERM] {
            return bc
        } else{
            exit(0)
        }
    }
    
    /// Dependancy injection - only to be used for testing
    ///
    /// - Parameter dependencies: dependencies
    func setDependencies(dependencies: Dependencies) throws{
        self.dependencies = dependencies
        self.taxInfo = [FilingStatusEnum: [TaxType: TaxBrackets]]()
        try initializeTaxBracketMap()
    }
    
    private func initializeTaxBracketMap() throws{
        
        var bracketInfoArray :[String] = []
        
        let taxTypes = self.dependencies.getTaxTypes()
        
        var singleMap:[TaxType:TaxBrackets] = [:]
        var marriedMap:[TaxType:TaxBrackets] = [:]
        var headMap:[TaxType:TaxBrackets] = [:]
        var marriedSMap:[TaxType:TaxBrackets] = [:]
        
        do {
            
            for taxType in taxTypes {
                
                try bracketInfoArray =  Utility.getFileContentsAsStringArray(fileName: taxType.rawValue, type:file_type)
                
                let singleBrackets: TaxBrackets = TaxBrackets()
                let marriedBrackets: TaxBrackets = TaxBrackets()
                let headBrackets: TaxBrackets =  TaxBrackets()
                let married_s_Brackets: TaxBrackets = TaxBrackets()
                
                var count = 0
                for bracketInfo in bracketInfoArray {
                    
                    // first line is the heading
                    if count == 0 {
                        count = count + 1
                        continue
                    }
                    
                    var elements = Utility.splitString(bracketInfo, separator: ",")
                    
                    // if there are less than 2 values
                    if elements.count < 2 {
                        continue
                    }
                    
                    let rate = Double(elements[BracketEnum.rate.rawValue])
                    
                    let single_start = Double(elements[BracketEnum.single_start.rawValue])
                    let single_end = Double(elements[BracketEnum.single_end.rawValue])
                    
                    singleBrackets.add(bracket: Bracket(rate: rate!, startRange: single_start!, endRange: single_end))
                    
                    let married_start = Double(elements[BracketEnum.married_start.rawValue])
                    let married_end = Double(elements[BracketEnum.married_end.rawValue])
                    
                    marriedBrackets.add(bracket: Bracket(rate: rate!, startRange: married_start!, endRange: married_end))
                    
                    let head_start = Double(elements[BracketEnum.head_start.rawValue])
                    let head_end = Double(elements[BracketEnum.head_end.rawValue])
                    
                    headBrackets.add(bracket: Bracket(rate: rate!, startRange: head_start!, endRange: head_end))
                    
                    let married_s_start = Double(elements[BracketEnum.married_s_start.rawValue])
                    let married_s_end = Double(elements[BracketEnum.married_s_end.rawValue])
                    
                    married_s_Brackets.add(bracket: Bracket(rate:rate!, startRange: married_s_start!, endRange: married_s_end))
                    
                    count = count + 1
                    
                }
                singleMap[taxType] = singleBrackets
                marriedMap[taxType] = marriedBrackets
                headMap[taxType] = headBrackets
                marriedSMap[taxType] = married_s_Brackets
            }
            
            self.taxInfo[FilingStatusEnum.single] = singleMap
            self.taxInfo[FilingStatusEnum.married] = marriedMap
            self.taxInfo[FilingStatusEnum.head] = headMap
            self.taxInfo[FilingStatusEnum.married_s] = marriedSMap
            
        } catch {
            throw TaxCalculationError.catalogueProcessingError
        }
        
    }
        
    //static dependencies
    class Dependencies {
        
        func getTaxTypes() -> [TaxType]{
            return TaxType.all
        }
    }
    
}
