//
//  ViaPlay_TechTestUITests.swift
//  ViaPlay-TechTestUITests
//
//  Created by Alessandro dos Santos Pinto on 21/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest

class DummyUItests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["series"].tap()
        tablesQuery.staticTexts["movie"].tap()
        tablesQuery.children(matching: .cell).element(boundBy: 2).staticTexts["sport"].tap()
        
        let backButton = app.navigationBars["ViaPlay_TechTest.HomeSessionView"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        backButton.tap()
        tablesQuery.staticTexts["kids"].tap()
        backButton.tap()
        backButton.tap()
        backButton.tap()
        
    }
    
    
    
}