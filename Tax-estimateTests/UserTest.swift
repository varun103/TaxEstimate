//
//  UserTest.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 2/19/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

@testable import Tax_estimate
import XCTest

class UserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTaxableIncome() {
        let user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(10000, user.getTaxableIncome())
    }
    
    func testFederalTax() {
        
    }
    
    func testPreTaxDeductions() {
        let user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(10000, user.getTaxableIncome())
        
        var deduction1: PreTaxDeduction = FourOOneKPreTaxDeduction()
        var deduction2: PreTaxDeduction = FSAHealthPreTaxDeduction()
        
        user.addPreTaxDeduction(deduction: deduction1)
        user.addPreTaxDeduction(deduction: deduction2)
        
        user.setContributionAmount()
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(10000, user.getTaxableIncome())
        
        deduction1.contributionAmount = 2000
        
        user.setContributionAmount()
        XCTAssertEqual(10,user.getFedTaxBracket().getRate())
        XCTAssertEqual(8000, user.getTaxableIncome())
        
        deduction2.contributionAmount = 4000
        
        user.setContributionAmount()
        XCTAssertEqual(10,user.getFedTaxBracket().getRate())
        XCTAssertEqual(4000, user.getTaxableIncome())


    }
    
    func testFederalTaxAfterContribution() {
//        let user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
//        user.setContributionAmount(newContributionAmout: 1200)
        
    }
}
