//
//  TaxBracketsTests.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate

class TaxInfoTests: XCTestCase {

      
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetTaxInfo(){
        let dependenies = TestDependencies()

        let info = TaxInfoServiceImpl(income: 0.0, dependencies: dependenies)
        
        let taxCatalogue = info.getCatalogue()
        
        XCTAssertNotNil(taxCatalogue)
        XCTAssertEqual(3, taxCatalogue.count)
        
        let keys = taxCatalogue.keys
        
        XCTAssertTrue(keys.contains(FilingStatusEnum.head))
        XCTAssertTrue(keys.contains(FilingStatusEnum.married))
        XCTAssertTrue(keys.contains(FilingStatusEnum.single))
        
    }
    
    
    class TestDependencies: TaxInfoServiceImpl.Dependencies {
        
        override func getTaxTypes() -> [TaxType] {
            return TaxType.test
        }
    }
}
