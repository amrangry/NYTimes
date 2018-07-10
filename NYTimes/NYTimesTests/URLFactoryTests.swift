//
//  URLFactoryTest.swift
//  NYTimesTests
//
//  Created by Amr ELghadban on 7/10/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

@testable import NYTimes
import XCTest

class URLFactoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /// This is an example of a functional test case API Path MostViewed if section and timePeiord is giver it shouldn't be null
    func testAPIPathStringForMostViewed() {
        // Given a section and time period, the API path should always be returned.
        let mostViewedStringPath = URLFactory.getURL(.mostviewed, section: "all-sections", timePeriod: "7").stringPath
        XCTAssertNotNil(mostViewedStringPath)
    }

    /// This is an example of a functional test case API Path MostViewed if section and timePeiord is giver it shouldn't be null
    func testAPIPathURLForMostViewed() {
        let mostViewedStringPathURL = URLFactory.getURL(.mostviewed, section: "all-sections", timePeriod: "7").url
        XCTAssertNotNil(mostViewedStringPathURL)
    }

    func testPathExplicitKeysIsAvailable() {
        guard let mostViewedStringPath = URLFactory.getURL(.mostviewed, section: "all-sections", timePeriod: "7").stringPath else {
            return
        }
        XCTAssertNotNil(mostViewedStringPath)
        XCTAssertTrue(mostViewedStringPath.contains("api-key="))
        XCTAssertTrue(mostViewedStringPath.contains(".json"))
    }
}
