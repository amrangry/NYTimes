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

    var storyboard: UIStoryboard?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main",
                                  bundle: Bundle.main)

        XCTAssertNotNil(storyboard)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        super.tearDown()
    }

    func testMostViewedMasterViewController() {
        let mostViewedMasterViewController = storyboard?.instantiateViewController(withIdentifier: "MostViewedMasterViewController")

        XCTAssertNotNil(mostViewedMasterViewController)
        XCTAssertTrue(mostViewedMasterViewController is MostViewedMasterViewController)
    }

    func testDetailViewController() {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController")

        XCTAssertNotNil(detailViewController)
        XCTAssertTrue(detailViewController is DetailViewController)
    }
}
