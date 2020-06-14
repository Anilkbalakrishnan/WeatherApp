//
//  weatherTests.swift
//  weatherTests
//
//  Created by Anil Kallamkatil Balakrishnan on 12/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import XCTest
@testable import weather

class weatherTests: XCTestCase {

   
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testNightIconNames(){
        let symbol1 = Symbol(sunup: false, n: 1, clouds: 2, precip: 3, symbolVar: "Moon")
        XCTAssertEqual(symbol1.getIconName, "01n")
        let symbol2 = Symbol(sunup: false, n: 2, clouds: 2, precip: 3, symbolVar: "Moon")
        XCTAssertEqual(symbol2.getIconName, "02n")
        let symbol3 = Symbol(sunup: false, n: 10, clouds: 2, precip: 3, symbolVar: "Moon")
        XCTAssertEqual(symbol3.getIconName, "10n")
    }
    
    func testMidDayIconNames(){
        let symbol1 = Symbol(sunup: false, n: 1, clouds: 2, precip: 3, symbolVar: "Sun")
        XCTAssertEqual(symbol1.getIconName, "01d")
        let symbol2 = Symbol(sunup: false, n: 2, clouds: 2, precip: 3, symbolVar: "Sun")
        XCTAssertEqual(symbol2.getIconName, "02d")
        let symbol3 = Symbol(sunup: false, n: 10, clouds: 2, precip: 3, symbolVar: "Sun")
        XCTAssertEqual(symbol3.getIconName, "10d")
    }
    
    func testIconWithoutVarNames(){
        let symbol1 = Symbol(sunup: false, n: 1, clouds: 2, precip: 3, symbolVar: nil)
        XCTAssertEqual(symbol1.getIconName, "01")
        let symbol2 = Symbol(sunup: false, n: 2, clouds: 2, precip: 3, symbolVar: nil)
        XCTAssertEqual(symbol2.getIconName, "02")
        let symbol3 = Symbol(sunup: false, n: 10, clouds: 2, precip: 3, symbolVar: nil)
        XCTAssertEqual(symbol3.getIconName, "10")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
