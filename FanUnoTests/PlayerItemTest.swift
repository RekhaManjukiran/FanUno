//
//  PlayerItemTest.swift
//  FanUno
//
//  Created by Manju Kiran on 23/10/2017.
//  Copyright © 2017 Rekha Manju Kiran. All rights reserved.
//

import XCTest
@testable import FanUno

class PlayerItemTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
          }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let leftPlayerItem: Player = Player.init(firstName: "Left", lastName: "Player", fppg: 30.0, imageUrl: [])
        
        let rightPlayerItem:Player = Player.init(firstName: "Right", lastName: "Player", fppg: 40.0, imageUrl: [])

        
        XCTAssertEqual(leftPlayerItem.fppg, 30, "Left Player FPPG is Incorrect")
        XCTAssertEqual(rightPlayerItem.fppg, 40, "Right Player FPPG is Incorrect")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
