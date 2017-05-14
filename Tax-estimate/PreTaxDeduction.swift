//
//  PreTaxDeductions.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 2/27/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

protocol PreTaxDeduction: class {
    
    var MAX_CONTRIBUTION_AMOUNT:Int {get}
    
    var contributionAmount:Int {get}
    
    var delegate:DeductionDelegate? {get set}
    
    var affects:[TaxType]{get}
    
    func getContributionAmount() -> Int
    
    func setContributionAmount(amount: Int) throws
}

protocol DeductionDelegate {
    
    func deductionAmountChanged(_sender:PreTaxDeduction) throws
    
}


class FourOOneKPreTaxDeduction : PreTaxDeduction, CustomStringConvertible {
    
    var delegate: DeductionDelegate?
    
    var affects: [TaxType] = TaxType.all
    
    internal var MAX_CONTRIBUTION_AMOUNT: Int = Settings.MAX_401K_CONTRIBUTION

    public var description: String = "FourOOneKPreTaxDeduction"
    
    var _contributionAmount:Int
    
    
    func getContributionAmount() -> Int {
        return self._contributionAmount
    }
    
    func setContributionAmount(amount: Int) throws {
        self._contributionAmount = amount
        try self.delegate?.deductionAmountChanged(_sender: self)
    }
    
    var contributionAmount:Int {
        return self._contributionAmount
    }

    init(amount: Int) {
        self._contributionAmount = amount
    }

    init(){
        self._contributionAmount = 0
    }
}

final class FSAHealthPreTaxDeduction: PreTaxDeduction, CustomStringConvertible{
    
    var delegate: DeductionDelegate?

    var affects: [TaxType] = TaxType.all

    internal var MAX_CONTRIBUTION_AMOUNT: Int = Settings.MAX_FSA_CONTRIBUTION
    
    public var description: String = "FSAHealthPreTaxDeduction"
    
    var _contributionAmount:Int
    
    func getContributionAmount() -> Int {
        return self._contributionAmount
    }
    
    func setContributionAmount(amount: Int) throws {
        self._contributionAmount = amount
        try self.delegate?.deductionAmountChanged(_sender: self)
    }

    var contributionAmount: Int {
        return self._contributionAmount
    }
    
    init(amount: Int) {
        self._contributionAmount = amount
    }
    
    init(){
        self._contributionAmount = 0
    }
}
