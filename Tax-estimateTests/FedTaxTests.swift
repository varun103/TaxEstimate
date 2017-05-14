//
//  FedTaxTests.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/30/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//
@testable import Tax_estimate
import XCTest

class FedTaxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFedBracket() {
        var fedTax: FedTax = FedTax(income: 10000, capitalGains: CapitalGains(), status: FilingStatusEnum.married)
        XCTAssertEqual(fedTax.getBracket().getRate(), 10.0)
        fedTax = FedTax(income: 380000, capitalGains: CapitalGains(), status: FilingStatusEnum.married)
        XCTAssertEqual(fedTax.getBracket().getRate(), 33.0)
    }
    
    func testTaxableIncome() throws {
        let fedTax = FedTax(income: 10000, capitalGains: CapitalGains(), status: FilingStatusEnum.married)
        let fourOneK: PreTaxDeduction = FourOOneKPreTaxDeduction()
        fedTax.addPreTaxDeduction(deduction: fourOneK)
        try fourOneK.setContributionAmount(amount: 500)
        try fedTax.calculate()
        XCTAssertEqual(fedTax.getTaxableIncome(), 9500)
    }
    
    func testLongTermTax() throws {
        let fedTax = FedTax(income: 10000, capitalGains: CapitalGains(), status: FilingStatusEnum.married)
        
        let longTermTax = try fedTax.getLongTermGainsTax(incMinusLTGains: 0, incPlusLTGains: 100000)
        XCTAssertEqual(3704, longTermTax)

        
    }
}
