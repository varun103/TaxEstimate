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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTaxableIncome() {
        let user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(10000, user.getTaxableIncome())

        
        user.setContributionAmount(newContributionAmout: 2000)
        XCTAssertEqual(10, user.getFedTaxBracket().getRate())
        XCTAssertEqual(8000, user.getTaxableIncome())
        
        user.setContributionAmount(newContributionAmout: 0)
        XCTAssertEqual(15,user.getFedTaxBracket().getRate())
        XCTAssertEqual(10000, user.getTaxableIncome())
    }
    
    func testFederalTaxAfterContribution() {
        let user =  User(filingStatus: FilingStatusEnum.single, income: 10000, state: TaxType.FED)
        user.setContributionAmount(newContributionAmout: <#T##Int#>)
        
    }
}
