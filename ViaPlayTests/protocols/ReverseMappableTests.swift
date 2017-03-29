//
//  ReverseMappableTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 23/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
@testable import ViaPlay

class ReverseMappableTests: XCTestCase {
    
    func testReverseMappableString() {
        let value: String = "Viaplay"
        XCTAssertEqual(value.toJSON() as? String, "Viaplay")
    }
    
    func testReverseMappableFloat() {
        let value: Float = 3.14159
        XCTAssertEqual(value.toJSON() as? Float, 3.14159)
    }
    
    func testReverseMappableDouble() {
        let value: Double = 10.34
        XCTAssertEqual(value.toJSON() as? Double, 10.34)
    }
    
    func testReverseMappableInt() {
        let value: Int = 2
        XCTAssertEqual(value.toJSON() as? Int, 2)
    }
    
    func testReverseMappableURL() {
        let value = URL(string: "http://www.apple.com")
        XCTAssertEqual(value.toJSON() as? String, "http://www.apple.com")
    }
    
    func testReverseMappableBool() {
        let value = true
        XCTAssertEqual(value.toJSON() as? Bool, true)
    }
    
    func testReverseMappableDictionary() {
        let value: NSDictionary = ["title": "Title", "description": "Description"]
        XCTAssertEqual(value.toJSON() as? NSDictionary, value);
    }
    
    func testReverseMappableArray() {
        let value = [1, 2, 3]
        XCTAssertEqual(value.toJSON() as! [Int], [1, 2, 3]);
    }
    
    func testReverseMappableOptional() {
        let value: String? = "Viaplay"
        XCTAssertEqual(value.toJSON() as? String, "Viaplay")
    }
    
    func testReverseMappableOptionalArray() {
        let value: [Int]? = [1, 2, 3]
        XCTAssertEqual(value.toJSON() as! [Int], [1, 2, 3])
    }
    
    func testReverseMappableEnum() {
        enum Suit: String, ReverseMappable {
            case spades = "♠"
            case hearts = "♥"
            case diamonds = "♦"
            case clubs = "♣"
        }

        XCTAssertEqual(Suit.spades.toJSON() as? String, "♠")
        XCTAssertEqual(Suit.hearts.toJSON() as? String, "♥")
        XCTAssertEqual(Suit.diamonds.toJSON() as? String, "♦")
        XCTAssertEqual(Suit.clubs.toJSON() as? String, "♣")
    }
}
