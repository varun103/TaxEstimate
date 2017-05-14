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
        var user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(1036, user.getFederalTax())
        
        user = User(filingStatus: FilingStatusEnum.married, income: 231451, state: TaxType.CA)
        XCTAssertEqual(33, user.getFedTaxBracket().getRate())
        XCTAssertEqual(51790, user.getFederalTax())
        
        user = User(filingStatus: FilingStatusEnum.married_s, income: 115726, state: TaxType.CA)
        XCTAssertEqual(33, user.getFedTaxBracket().getRate())
        XCTAssertEqual(25895, user.getFederalTax())
    }
    
    func testPreTaxDeductions() throws {
        let user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(10000, user.getTaxableIncome())
        
        let deduction1: PreTaxDeduction = FourOOneKPreTaxDeduction()
        let deduction2: PreTaxDeduction = FSAHealthPreTaxDeduction()
        
        user.addPreTaxDeduction(deduction: deduction1)
        user.addPreTaxDeduction(deduction: deduction2)
        
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(10000, user.getTaxableIncome())
        
        try deduction1.setContributionAmount(amount: 2000)
        
        XCTAssertEqual(10,user.getFedTaxBracket().getRate())
        XCTAssertEqual(8000, user.getTaxableIncome())
        
        try deduction2.setContributionAmount(amount: 4000)
        
        XCTAssertEqual(10,user.getFedTaxBracket().getRate())
        XCTAssertEqual(4000, user.getTaxableIncome())
        
    }
    
    func testFederalTaxAfterContribution() {
//        let user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
//        user.setContributionAmount(newContributionAmout: 1200)
        
    }
}
