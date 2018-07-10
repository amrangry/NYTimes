//
//  APIRequestHandlerTest.swift
//  NYTimesTests
//
//  Created by Amr ELghadban on 7/10/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import XCTest

class APIRequestHandlerTest: XCTestCase {
    var apiRequestHandlerUnderTest: APIRequestHandler!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiRequestHandlerUnderTest = APIRequestHandler.share
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiRequestHandlerUnderTest = nil
        super.tearDown()
    }

    /// Asynchronous test: success fast, failure slow
    /// This is an example of a performance test case for calling MostViewed API
    func testMostViewedAPICall() {
        // given
        weak var expectation = self.expectation(description: "Response Received")

        guard let urlRoute = URLFactory.getURL(.mostviewed, section: "all-sections", timePeriod: "7").url else {
            // then
            XCTFail("Error: url not valid")
            return
        }

        guard let urlRequest = apiRequestHandlerUnderTest.createRequest(url: urlRoute, forceUpdate: false) else {
            // then
            XCTFail("Error: URLRequest not valid")
            return
        }
        // when
        apiRequestHandlerUnderTest.InvokeURLRequest(request: urlRequest) { result in
            // then
            XCTAssertNotNil(result)
            switch result {
            case .success(let value):
                XCTAssertNotNil(value)
                expectation?.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 30) { error in
            XCTAssertNil(error)
        }
    }
}
