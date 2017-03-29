//
//  ViaPlay_TechTestUITests.swift
//  ViaPlay-TechTestUITests
//
//  Created by Alessandro dos Santos Pinto on 21/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest

class ViaPlayUITests: XCTestCase {
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testBasicUserFlow() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["series"].tap()
        tablesQuery.staticTexts["movie"].tap()
        tablesQuery.children(matching: .cell).element(boundBy: 2).staticTexts["sport"].tap()
        
        let backButton = app.navigationBars.children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        backButton.tap()
        tablesQuery.staticTexts["kids"].tap()
        backButton.tap()
        backButton.tap()
        backButton.tap()
    }
}
