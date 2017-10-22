//
//  NetworkTest.swift
//  FanUno
//
//  Created by Manju Kiran on 23/10/2017.
//  Copyright © 2017 Rekha Manju Kiran. All rights reserved.
//

import XCTest
@testable import FanUno

class NetworkTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlayerDataDownload() {
        let networkUnderTest = Network()
        let promise = expectation(description: "Players Downloaded and parsed")
        networkUnderTest.retrievePlayersJSON { (success, players) in
            if(success){
                promise.fulfill()
            }else{
                XCTFail("Could not fetch players list")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
