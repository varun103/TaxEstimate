//
//  PreTaxDeductionTests.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 2/27/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate

class PreTaxDeductionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetterSetter() {
        var fourOOnePreTaxDeduction:PreTaxDeduction = FourOOneKPreTaxDeduction()
        XCTAssertEqual(0, fourOOnePreTaxDeduction.contributionAmount)

        fourOOnePreTaxDeduction.contributionAmount = 400
        XCTAssertEqual(400, fourOOnePreTaxDeduction.contributionAmount)
        
        
        fourOOnePreTaxDeduction = FourOOneKPreTaxDeduction(amount: 1)
        XCTAssertEqual(1, fourOOnePreTaxDeduction.contributionAmount)

    }
}
