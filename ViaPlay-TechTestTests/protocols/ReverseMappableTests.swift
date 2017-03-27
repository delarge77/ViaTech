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
        
        XCTAssertNotNil(json, "Value must not be nil");
        
        if let txt = json as? String {
            XCTAssertEqual(txt, "reversable")
        }
    }
    
    func testReverseMappableFloat() {
        let value: Float = 3.14159
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
        
        if let json = json as? Float {
            XCTAssertEqual(json, 3.14159)
        }
    }
    
    func testReverseMappableDouble() {
        let value: Double = 10.34
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
        
        if let json = json as? Double {
            XCTAssertEqual(json, 10.34)
        }
    }
    
    func testReverseMappableInt() {
        let value = 2
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
        
        if let json = json as? Int {
            XCTAssertEqual(json, 2)
        }
    }
    
    func testReverseMappableURL() {
        let value = URL(string: "http://www.apple.com")
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
    }
    
    func testReverseMappableBool() {
        let value = true
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
    }
    
    func testReverseMappableDictionary() {
        let expectedJSON = [
            "title": "Title",
            "description": "Description"
            ] as NSDictionary
        
        guard let json = expectedJSON.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
    }
    
    func testReverseMappableArray() {
        let convertableArray = ["Title", "description"] as Array
        
        guard let json = convertableArray.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "value must not be nil");
    }
    
    func testReverseMappableOptional() {
        
        let text: String? = "Viaplay"
        
        guard let json = text.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
        
        if let txt = json as? String {
            XCTAssertEqual(txt, "Viaplay")
        }
    }
    
    func testReverseMappableOptionalArray() {
        
        let value: [Int]? = [1, 2, 3]
        
        guard let json = value.toJSON() else {
            return
        }
        
        XCTAssertNotNil(json, "Value must not be nil");
        
        if let json = json as? NSArray {
            XCTAssertEqual(json, [1, 2, 3])
        }
    }
    
    func testReverseMappableEnum() {
        
        enum Suit: String, ReverseMappable {
            case spades = "♠"
            case hearts = "♥"
            case diamonds = "♦"
            case clubs = "♣"
        }
        
        guard let spades = Suit.spades.toJSON() else {
            return
        }
        
        guard let hearts = Suit.hearts.toJSON() else {
            return
        }
        guard let diamonds = Suit.diamonds.toJSON() else {
            return
        }
        
        guard let clubs = Suit.clubs.toJSON() else {
            return
        }
        
        XCTAssertNotNil(spades, "Value must not be nil");
        XCTAssertEqual(Suit.spades.rawValue, "♠")
        XCTAssertNotNil(hearts, "Value must not be nil");
        XCTAssertEqual(Suit.hearts.rawValue, "♥")
        XCTAssertNotNil(diamonds, "Value must not be nil");
        XCTAssertEqual(Suit.diamonds.rawValue, "♦")
        XCTAssertNotNil(clubs, "Value must not be nil");
        XCTAssertEqual(Suit.clubs.rawValue, "♣")
    }
}
