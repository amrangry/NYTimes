//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Amr ELghadban on 6/30/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

@testable import NYTimes
import XCTest

class MainStoryBoardTest: XCTestCase {

    // MARK: Varibels To test

    // (SUT) system unit under test
    var storyboardUnderTest: UIStoryboard!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Given
        storyboardUnderTest = UIStoryboard(name: "Main",
                                           bundle: Bundle.main)
        // Then
        XCTAssertNotNil(storyboardUnderTest)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboardUnderTest = nil
        super.tearDown()
    }

    func testMostViewedMasterViewController() {
        // Given
        let mostViewedMasterViewController = storyboardUnderTest.instantiateViewController(withIdentifier: "MostViewedMasterViewController")
        // Then
        XCTAssertNotNil(mostViewedMasterViewController)
        XCTAssertTrue(mostViewedMasterViewController is MostViewedMasterViewController)
    }

    func testDetailViewController() {
        // Given
        let detailViewController = storyboardUnderTest.instantiateViewController(withIdentifier: "DetailViewController")
        //then
        XCTAssertNotNil(detailViewController)
        XCTAssertTrue(detailViewController is DetailViewController)
    }
}
