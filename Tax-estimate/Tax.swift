//
//  Tax.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/28/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class Tax {
    
    // wages and salary
    var initialIncome: Double
    // income to be taxed
    var totalTaxableIncome: Double
    // income to be taxed at marginal tax rate
    var taxableIncome: Double
    // tax amount
    var taxAmount : Int
    
    var preTaxDeductions: PreTaxDeductions
    
    var status: FilingStatusEnum
    
    var bracket: Bracket
    var capitalGains: CapitalGains
    var taxInfo: TaxInfoService = TaxInfoServiceImpl.getInstance()
    
    init(income: Double, capitalGains: CapitalGains, status: FilingStatusEnum, preTaxDeductions: PreTaxDeductions) {
        self.initialIncome = income
        self.taxableIncome = self.initialIncome
        self.status = status
        self.bracket = Tax.setTaxBracket()
        self.preTaxDeductions = PreTaxDeductionsImpl()
        self.capitalGains = capitalGains
        self.taxAmount = 0
        self.totalTaxableIncome = 0
        do {
            try calculate()
        }catch{}
    }
    
    convenience init(income: Double, capitalGains: CapitalGains, status: FilingStatusEnum) {
        self.init(income: income, capitalGains: capitalGains, status: status, preTaxDeductions: PreTaxDeductionsImpl())
    }
    
    func getBracket() -> Bracket{
        return self.bracket
    }
    
    /// - Returns: Taxble income
    func getTaxableIncome() -> Double {
        return self.taxableIncome
    }
    
    /// - Returns: the tax
    func getTax() -> Int {
        var _tax:Double = 0.0
        do {
            try _tax = self.bracket.getTax(self.taxableIncome)
        } catch {
        }
        return Int(_tax)
    }
    
    func getTaxSavings() -> Int {
        do {
            return try (Int((Double(getPreTaxDeduction())) * self.bracket.getPercentage()))
        }catch {}
        return 0
    }
    
    func addPreTaxDeduction(deduction: PreTaxDeduction) {
        self.preTaxDeductions.add(preTaxDeduction: deduction)
        do {
            try calculate()
        }catch{}
    }
    
    func getPreTaxDeduction() throws -> Int {
        let amount = self.preTaxDeductions.getAmount()
        
        if (amount > Int(self.initialIncome)) {
            throw UserInputError.deductionAmountExceedError
        }
        return amount
    }
    
    func capitalGainsTax() {}
    
    func calculate() throws {}
    
    static func setTaxBracket() -> Bracket {
        return Bracket(rate:0,startRange: 0,endRange: 0)
    }
}
