//
//  VirtualFridgeControllerTest.swift
//  Backend Unit Tests
//
//  Created by Mark Kang on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import XCTest
@testable import appetit
import CoreData

class VirtualFridgeControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddIngredients() {
        let testUser = VirtualFridgeController()
//        try testUser.addIngredient(email: "", ingredient: "", servings: 0)
        XCTAssertEqual(true, true)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
