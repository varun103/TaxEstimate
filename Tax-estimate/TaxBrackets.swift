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
    
    private var taxBrackets = [FilingStatus: [TaxBracket]]()
    
    
    init(income:Float){
        self.income = income
        self.federal_tax = 0.0
        initializeTaxBracketMap()
    }
    
    
    func getTaxBracketForUser(user: UserProtocol) -> TaxBracket? {
        return nil
    }
    
    private func initializeTaxBracketMap(){
        
    }
    
    func readFile(){
        let filePath = NSBundle.mainBundle().resourcePath!
        print(filePath)
        
        let file = "/Users/vajmera/tax.txt"
        do {
            let fileContent = try NSString(contentsOfFile: file, encoding: NSUTF8StringEncoding)
            print(fileContent)
        } catch{
            
        }
    }
}
