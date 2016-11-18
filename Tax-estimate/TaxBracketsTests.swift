//
//  TaxBracketsTests.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate

class TaxBracketsTests: XCTestCase {

      
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetTaxBrackets(){
        let dependenies = TestDependencies()

        let brackets = TaxBrackets(income: 0.0, dependencies: dependenies)
        
        let tbs = brackets.getTaxBrackets()
        XCTAssertNotNil(tbs)
        XCTAssertEqual(1, tbs.count)
        //XCTAssertTrue(tbs.first)
    }
    
    class TestDependencies: TaxBrackets.Dependencies {
        
        override func getTaxTypes() -> [TaxType] {
            return TaxType.test
        }
    }
}
