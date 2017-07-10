//
//  FedTax.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/28/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

/// Description
class FedTax: Tax {
    
    // tax on long term capital gains
    private(set) var longTermGainsTax: Int
    
    
    override init(income: Double, capitalGains: CapitalGains, status: FilingStatusEnum, preTaxDeductions: PreTaxDeductions) {
        self.longTermGainsTax = 0
        super.init(income: income, capitalGains: capitalGains, status: status, preTaxDeductions:preTaxDeductions)
    }
    
    /// Main method to calculate the tax. Should be called anytime there is a change to any params
    override func calculate() throws {
        
        // calculate the total income
        self.totalTaxableIncome = try self.initialIncome - Double(getPreTaxDeduction()) + Double(self.capitalGains.net(status: status))

        if (self.totalTaxableIncome < 0) {
            //TODO
        }
        
        var _incomeMinusLTGain = self.totalTaxableIncome - Double(self.capitalGains.effectiveLongTerm)
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
    
    override func longTermCapitalGainsTax() -> Int {
        return self.longTermGainsTax
    }
    
    override func shortTermCapitalGainsTax() -> Int {
        var _tax = 0
        if (self.capitalGains.shortTermGains > 0 ) {
            do {
                _tax = try self.getShortTermGainsTax(incMinusSTGains: self.taxableIncome - Double(self.capitalGains.shortTermGains), incPlusSTGains: self.taxableIncome)
            } catch {}
        }
        return _tax
    }

    
    private func getLongTermGainsTax(incMinusLTGains:Double, incPlusLTGains:Double) throws -> Int {
        let taxForIncomeMinusLT = try self.taxInfo.getLongTermGainsTaxBracket(filingStatus: self.status).getTax(income: incMinusLTGains)
        
        let taxForIncomePlusLT = try self.taxInfo.getLongTermGainsTaxBracket(filingStatus: self.status).getTax(income: incPlusLTGains)
        
        return Int(taxForIncomePlusLT - taxForIncomeMinusLT)
    }
    
    private func getShortTermGainsTax(incMinusSTGains:Double, incPlusSTGains:Double) throws -> Int {
        let taxForIncomeMinusST = try self.taxInfo.getFedBrackets(self.status).getTax(income: incMinusSTGains)
        
        let taxForIncomePlusST = try self.taxInfo.getFedBrackets(self.status).getTax(income: incPlusSTGains)
        
        return Int(taxForIncomePlusST - taxForIncomeMinusST)
    }
}
