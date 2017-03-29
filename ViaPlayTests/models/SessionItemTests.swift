//
//  SessionItemTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 22/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
import Foundation
import OHHTTPStubs
@testable import ViaPlay

class SessionItemTests: XCTestCase {

    func testShouldCreateSessionItemForValidJSON() {
        let JSON: NSDictionary = [
            "href": "https://www.apple.com",
            "id": "123",
            "name": "Movies",
            "templated": true,
            "title": "The best movies",
            "type": "video"
        ]
        let item = SessionItem.from(JSON)
        let convertedJSON = item?.toJSON()

        XCTAssertNotNil(item)
        XCTAssertEqual(item?.href.absoluteString, "https://www.apple.com")
        XCTAssertEqual(item?.itemID, "123")
        XCTAssertEqual(item?.name, "Movies")
        XCTAssertEqual(item?.templated, true)
        XCTAssertEqual(item?.itemTitle, "The best movies")
        XCTAssertEqual(item?.itemType, "video")

        XCTAssertTrue(convertedJSON is NSDictionary)
        XCTAssertEqual(convertedJSON as! NSDictionary, JSON)
    }

    func testShouldNotCreateSessionItemForInvalidJSON() {
        let JSON: NSDictionary = [
            "id": "123"
        ]
        let item = SessionItem.from(JSON)

        XCTAssertNil(item)
    }

    func testShouldRemoveDownloadableContentTagFromURL() {
        let JSON: NSDictionary = [
            "href": "https://www.apple.com{?dtg}",
            "id": "123",
            "name": "Movies",
            "templated": true,
            "title": "The best movies",
            "type": "video"
        ]
        let item = SessionItem.from(JSON)

        XCTAssertEqual(item?.href.absoluteString, "https://www.apple.com")
    }

    func testShouldNotCreateSessionItemIfURLIsInvalid() {
        let JSON: NSDictionary = [
            "href": "",
            "id": "123",
            "name": "Movies",
            "templated": true,
            "title": "The best movies",
            "type": "video"
        ]
        let item = SessionItem.from(JSON)

        XCTAssertNil(item)
    }
    
}
