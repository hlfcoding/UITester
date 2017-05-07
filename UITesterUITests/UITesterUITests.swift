//
//  UITesterUITests.swift
//  UITesterUITests
//
//  Copyright (c) 2015-present Peng Wang. All rights reserved.
//

import XCTest

class UITesterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let collectionView = XCUIApplication().collectionViews.element
        XCTAssert(collectionView.exists)
        collectionView.cells["Cell at section 0 item 0"].tap()

        XCTAssert(collectionView.exists)
        collectionView.cells["Cell at section 0 item 0"].tap()
    }
    
}
