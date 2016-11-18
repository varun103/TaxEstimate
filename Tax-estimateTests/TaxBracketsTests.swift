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
    
    func testGetBracket(){
        let b1 = Bracket(bracket: 10, startRange: 0, endRange: 1000)
        let b2 = Bracket(bracket: 20, startRange: 1001, endRange: nil)
        
        let brackets:[Bracket] = [b1,b2]
        
        let taxBrackets:TaxBrackets = TaxBrackets(brackets: brackets)
        
        XCTAssertEqual(10, taxBrackets.getBracket(income: 999).value())
        
        XCTAssertEqual(20, taxBrackets.getBracket(income: 1001).value())
    }
    
}
