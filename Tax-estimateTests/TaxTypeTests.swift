//
//  TaxTypeTests.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/8/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate

class TaxTypeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAll(){
        let allTaxTypes = TaxType.all
        XCTAssertEqual(2, allTaxTypes.count)
    }
}
