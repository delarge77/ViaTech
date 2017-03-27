//
//  ReverseMappableTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 23/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
@testable import ViaPlay_TechTest

class ReverseMappableTests: XCTestCase {
    
    func testReverseMappableJson() {
        let session = Session(title: "Title", descSession: "Description", sessionId: nil, sessionItem: nil)
        guard let JSON = session.toJSON() as? NSDictionary else {
            return
        }
        
        let expectedJSON = [
            "title": "Title",
            "description": "Description"
            ] as NSDictionary
        
        XCTAssertEqual(JSON, expectedJSON)
    }
    
    func testReverseMappableString() {
        let text = "reversable"
        
        guard let json = text.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
    func testReverseMappableFloat() {
        let value = -273.15
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
    func testReverseMappableInt() {
        let value = 2
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
    func testReverseMappableURL() {
        let value = URL(string: "http://www.apple.com")
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
    func testReverseMappableBool() {
        let value = true
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
    func testReverseMappableDictionary() {
        let expectedJSON = [
            "title": "Title",
            "description": "Description"
            ] as NSDictionary
        
        guard let json = expectedJSON.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
    func testReverseMappableArray() {
        let convertableArray = ["Title", "description"] as Array
        
        guard let json = convertableArray.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
    func testReverseMappableOptional() {
        
        let text: String? = "Viaplay"
        
        guard let json = text.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "");
    }
    
//    func testReverseMappableOptionalArray() {
//        
//        let array: [ReverseMappable]? = []
//        
//        guard let json = array.toJSON() else {
//            return
//        }
//        
//        XCTAssertNotNil(json, "");
//    }
}
