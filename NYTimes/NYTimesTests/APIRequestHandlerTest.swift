//
//  APIRequestHandlerTest.swift
//  NYTimesTests
//
//  Created by Amr ELghadban on 7/10/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import XCTest

class APIRequestHandlerTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /// This is an example of a performance test case for calling MostViewed API
    func testMostViewedAPICall() {
//        let expectation = self.expectation(description: "Response Received")
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//            guard let urlRoute = URLFactory.getURL(.mostviewed, section: "all-sections", timePeriod: "7").url else {
//                return
//            }
//
//            guard let url = APIRequestHandler.share.createRequest(url: urlRoute, forceUpdate: false) else {
//                return
//            }
//
//            APIRequestHandler.share.InvokeURLRequest(request: url) { response in
//                XCTAssertNotNil(response)
//                expectation.fulfill()
//            }
//        }

//        self.waitForExpectations(timeout: 30) { error in
//            XCTAssertNil(error)
//        }
    }
}
