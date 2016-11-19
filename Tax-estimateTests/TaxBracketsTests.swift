//
//  TaxBracketsTests.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/18/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate


class TaxBracketsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testGetBracket(){
//        let b1 = Bracket(rate: 10, startRange: 0, endRange: 1000)
//        let b2 = Bracket(rate: 20, startRange: 1001, endRange: nil)
//                
//        let taxBrackets:TaxBrackets = TaxBrackets()
//        
//        XCTAssertEqual(10, taxBrackets.getBracket(income: 999).value())
//        
//        XCTAssertEqual(20, taxBrackets.getBracket(income: 1001).value())
//    }
    
    func testIsEmpty(){
        let taxBrackets:TaxBrackets = TaxBrackets()
        XCTAssertTrue(taxBrackets.isEmpty())
    }
    
    func testCount(){
        let taxBrackets:TaxBrackets = TaxBrackets()
        XCTAssertEqual(0,taxBrackets.size())
        
        let b1 = Bracket(rate: 10, startRange: 0, endRange: 1000)
        let b2 = Bracket(rate: 20, startRange: 1001, endRange: nil)

        taxBrackets.add(bracket: b1)
        XCTAssertEqual(1,taxBrackets.size())
        
        taxBrackets.add(bracket: b2)
        XCTAssertEqual(2,taxBrackets.size())
    }
    
    func testGetTotalTax(){
        let b1 = Bracket(rate: 10, startRange: 0, endRange: 1000)
        let b2 = Bracket(rate: 20, startRange: 1000, endRange: 2000)
        let b3 = Bracket(rate: 30, startRange: 2000, endRange: nil)

        
        let taxBrackets:TaxBrackets = TaxBrackets()
        taxBrackets.add(bracket: b1)
        taxBrackets.add(bracket: b2)
        taxBrackets.add(bracket: b3)

        XCTAssertEqual(100, b1.totalTaxWPreviousBrackets())
        XCTAssertEqual(300, b2.totalTaxWPreviousBrackets())
        XCTAssertEqual(300, b3.totalTaxWPreviousBrackets())
    }
    
    func testFindBracket(){
        let b1 = Bracket(rate: 10, startRange: 0, endRange: 1000)
        let b2 = Bracket(rate: 20, startRange: 1000, endRange: 2000)
        let b3 = Bracket(rate: 30, startRange: 2000, endRange: nil)
        
        
        let taxBrackets:TaxBrackets = TaxBrackets()
        taxBrackets.add(bracket: b1)
        taxBrackets.add(bracket: b2)
        taxBrackets.add(bracket: b3)
        
        XCTAssertEqual(b1.getRate(), taxBrackets.findBracket(income: 999).getRate())
        XCTAssertEqual(b2.getRate(), taxBrackets.findBracket(income: 1999).getRate())
        XCTAssertEqual(b3.getRate(), taxBrackets.findBracket(income: 9990).getRate())

    }

    
    func testAdd(){
        let b1 = Bracket(rate: 10, startRange: 0, endRange: 1000)
        let b2 = Bracket(rate: 20, startRange: 1001, endRange: nil)
        
        let taxBrackets:TaxBrackets = TaxBrackets()
        taxBrackets.add(bracket: b1)
        taxBrackets.add(bracket: b2)
    }
    
    
}
