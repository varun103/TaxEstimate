//
//  FedTax.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/28/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class FedTax: Tax {
    
    // tax on long term capital gains
    private(set) var longTermGainsTax: Int
    
    // total income to be taxed
    private(set) var totalIncome: Double
    
    override init(income: Double, capitalGains: CapitalGains, status: FilingStatusEnum) {
        self.longTermGainsTax = 0
        self.totalIncome = 0
        super.init(income: income, capitalGains: capitalGains, status: status)
    }
    
    /// Main method to calculate the tax. Should be called anytime there is a change to any params
    override func calculate() throws {
        // calculate the total income
        self.totalIncome = try self.initialIncome - Double(getPreTaxDeduction()) + Double(self.capitalGains.net)
        
        if (self.totalIncome < 0) {
            //TODO
        }
        
        var _incomeMinusLTGain = self.totalIncome - Double(self.capitalGains.effectiveLongTerm)
        if (_incomeMinusLTGain < 0) {
            _incomeMinusLTGain = 0
        }
        
        self.taxableIncome = _incomeMinusLTGain
        
        self.bracket = self.taxInfo.getFedBrackets(self.status).findBracket(income: self.taxableIncome)
        
        do {
            let _taxForIncomeMinusLTGain = try self.bracket.getTax(self.taxableIncome)
            
            self.longTermGainsTax = try getLongTermGainsTax(incMinusLTGains: _incomeMinusLTGain, incPlusLTGains: (_incomeMinusLTGain + Double(self.capitalGains.effectiveLongTerm)))
            
            self.taxAmount = Int(_taxForIncomeMinusLTGain) + self.longTermGainsTax
            
        }catch {}
        
    }

    
    /// - Returns: Bracket Info
    override func getBracket() -> Bracket {
        return self.bracket
    }
    
    
    override func getTax() -> Int {
        return self.taxAmount
    }
    
    override func getPreTaxDeduction() throws -> Int {
        
        var amount:Int = 0
        for preTaxD in self.preTaxDeductions.all {
            amount = amount + preTaxD.getContributionAmount()
        }
        if (amount > Int(self.initialIncome)) {
            throw UserInputError.deductionAmountExceedError
        }
        return amount
    }
    
    // To calculate pre-tax deduction savings
    var taxableAmountWoPreTaxDeduction : Int {
        do {
            return try Int(self.taxableIncome) + getPreTaxDeduction()
        } catch {}
        return 0
    }
    
    override func getTaxSavings() -> Int {
        do {
            let bracketWoPreTaxDeduction = self.taxInfo.getFedBrackets(self.status).findBracket(income: Double(self.taxableAmountWoPreTaxDeduction))
            return try (Int((Double(getPreTaxDeduction())) * bracketWoPreTaxDeduction.getPercentage()))
        }catch {
        }
        return 0
    }
    
    
    func getLongTermGainsTax(incMinusLTGains:Double, incPlusLTGains:Double) throws -> Int {
        let taxForIncomeMinusLT = try self.taxInfo.getLongTermGainsTaxBracket(filingStatus: self.status).getTax(income: incMinusLTGains)
        
        let taxForIncomePlusLT = try self.taxInfo.getLongTermGainsTaxBracket(filingStatus: self.status).getTax(income: incPlusLTGains)
        
        return Int(taxForIncomePlusLT - taxForIncomeMinusLT)
    }
}
