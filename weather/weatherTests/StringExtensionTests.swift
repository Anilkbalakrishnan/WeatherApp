//
//  StringExtensionTests.swift
//  weatherTests
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import XCTest

@testable import weather
class StringExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTemperatureStringFormatWithDegree() {
        let temperatureString = "24"
        XCTAssertEqual(temperatureString.appendDegree , "24°")
        let temperatureinFloat: Float = 25.6
        XCTAssertEqual(temperatureinFloat.toTemperateString, "25°")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
