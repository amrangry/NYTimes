//
//  FormatEnumTest.swift
//  NYTimesTests
//
//  Created by Amr ELghadban on 7/10/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import XCTest

class FormatEnumTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFormatEnum() {
        XCTAssertFalse(Format.jumbo.rawValue != "Jumbo")
        XCTAssertFalse(Format.large.rawValue != "Large")
        XCTAssertFalse(Format.largeThumbnail.rawValue != "Large Thumbnail")
        XCTAssertFalse(Format.mediumThreeByTwo210.rawValue != "mediumThreeByTwo210")
        XCTAssertFalse(Format.mediumThreeByTwo440.rawValue != "mediumThreeByTwo440")
        XCTAssertFalse(Format.normal.rawValue != "Normal")
        XCTAssertFalse(Format.square320.rawValue != "square320")
        XCTAssertFalse(Format.square640.rawValue != "square640")
        XCTAssertFalse(Format.standardThumbnail.rawValue != "Standard Thumbnail")
        XCTAssertFalse(Format.superJumbo.rawValue != "superJumbo")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
