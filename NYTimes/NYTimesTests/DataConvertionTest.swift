//
//  DataConvertionTest.swift
//  NYTimesTests
//
//  Created by Amr ELghadban on 7/10/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

@testable import NYTimes
import XCTest

class DataConvertionTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /// This is an example of a functional test case for Data extension to convert String to data.
    func testDataConvertionFromString() {
        let stringValueToTest = "This is an example of a functional test case."
        let data = Data.convertToData(stringValueToTest)
        XCTAssertNotNil(data)
    }

    /// This is an example of a functional test case for Data extension to convert [String: AnyObject] to data.
    func testDataConvertionFromDictioanry() {
        let dictionValueToTest: [String: AnyObject] = ["key": 100 as AnyObject]
        let data = Data.convertToData(dictionValueToTest)
        XCTAssertNotNil(data)
    }

    /// This is an example of a functional test case for Data extension to convert [[String: AnyObject]] to data.
    func testDataConvertionFromArrayOfDictioanry() {
        let dictionValueToTest: [[String: AnyObject]] = [["key": 100 as AnyObject], ["key": 100 as AnyObject]]
        let data = Data.convertToData(dictionValueToTest)
        XCTAssertNotNil(data)
    }
}
