//
//  UtilsTest.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/31/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import XCTest
@testable import Tax_estimate

class UtilsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCsvParser(){
        var testString = "abc, hello, howare you"
        var components = Utility.csvParser(testString)
        XCTAssertEqual(3, components.capacity)
        XCTAssertEqual("abc", components[0])
        XCTAssertEqual(" hello", components[1])
        XCTAssertEqual(" howare you", components[2])
        
        testString = "abc"
        components = Utility.csvParser(testString)
        XCTAssertEqual(1, components.capacity)
        XCTAssertEqual("abc", components[0])
    }
    
    func testCsvParserEmpty(){
        let testString = ""
        let components = Utility.csvParser(testString)
        XCTAssertEqual(1, components.capacity)
        XCTAssertEqual("", components[0])
    }
    
    func testNewLine(){
        do {
        let fileString = try Utility.readFile("fedtax", type: "txt")
        let components = Utility.splitString(fileString, separator: "\n")
        XCTAssertEqual(8, components.capacity)
        } catch {
            XCTFail()
        }
    }
    

}
