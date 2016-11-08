//
//  Tax_estimateTests.swift
//  Tax-estimateTests
//
//  Created by Varun Ajmera on 10/23/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate

class Tax_estimateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetTaxForFullRange(){
        let tb = Bracket(bracket: 10,startRange: 0,endRange: 9000)
        XCTAssertEqual(900.0, tb.getTaxForFullRange())
    }
    
    func testGetTaxForMaxRange(){
        let tb = Bracket(bracket: 40, startRange: 100000, endRange: nil)
        XCTAssertEqual(0.0, tb.getTaxForFullRange())
    }
    
    func testGetTaxForRange() {
        let tb = Bracket(bracket: 10, startRange: 0, endRange: 10000)
        do{
            let original = try tb.getTax(5000)
            XCTAssertEqual(500.0, original )
        } catch {
            XCTFail("Exception thrown")
        }
    }
    
    func testGetTaxForRangeThrowsError() {
        let tb = Bracket(bracket: 10, startRange: 0, endRange: 10000)
        do{
            try tb.getTax(5000)
        } catch let e as TaxCalculationError {
            XCTAssertTrue(e == TaxCalculationError.OutOfTaxBracket)
        } catch {
            XCTFail("Exception throw")
        }
    }
    
}
