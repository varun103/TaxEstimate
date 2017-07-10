//
//  CapitalGainsTest.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 5/7/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate

class CapitalGainsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetterGetters() {
        let cg: CapitalGains = CapitalGains()
        XCTAssertEqual(0, cg.effectiveLongTerm)
        XCTAssertEqual(0, cg.net(status: FilingStatusEnum.married_s))
    }
    
    func testVariousValues() {
        var cg = CapitalGains(shortTerm: 200, longTerm: -4000)
        XCTAssertEqual(0, cg.effectiveLongTerm)
        XCTAssertEqual(-3000, cg.effectiveShortTerm)
        XCTAssertEqual(-1500, cg.net(status: FilingStatusEnum.married_s))
        
        cg = CapitalGains(shortTerm: -400, longTerm: -8000)
        XCTAssertEqual(0, cg.effectiveLongTerm)
        XCTAssertEqual(-3000, cg.effectiveShortTerm)
        XCTAssertEqual(-3000, cg.net(status: FilingStatusEnum.married))
        
        cg = CapitalGains(shortTerm: 200, longTerm: 1800)
        XCTAssertEqual(1800, cg.effectiveLongTerm)
        XCTAssertEqual(200, cg.effectiveShortTerm)
        XCTAssertEqual(2000, cg.net(status: FilingStatusEnum.married_s))
        
        cg = CapitalGains(shortTerm: -2000, longTerm: 10000)
        XCTAssertEqual(8000, cg.effectiveLongTerm)
        XCTAssertEqual(8000, cg.net(status: FilingStatusEnum.married_s))
    }
    
}
