//
//  SessionTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 22/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
import OHHTTPStubs
import UIKit
@testable import ViaPlay
import Mapper

class SessionTests: XCTestCase {
    
    func testSessionCreation() {
        let session = Session(title: "Title", descSession: "Description", sessionId: "1234", sessionItem: [])
        
        XCTAssertNotNil(session)
        XCTAssertEqual(session.title, "Title")
        XCTAssertEqual(session.descSession, "Description")
        XCTAssertEqual(session.sessionId, "1234")
        XCTAssertNotNil(session.sessionItem)
        XCTAssertEqual(session.sessionItem?.count, 0)
    }

    func testSessionCreationWithoutOptionals() {
        let JSON: NSDictionary = ["title": "Title", "description": "Description"]
        let session = Session.from(JSON)

        XCTAssertNotNil(session)
        XCTAssertEqual(session?.title, "Title")
        XCTAssertEqual(session?.descSession, "Description")
        XCTAssertNil(session?.sessionId)
        XCTAssertNil(session?.sessionItem)

        let convertedJSON = session.toJSON()

        XCTAssertNotNil(convertedJSON)
        XCTAssertTrue(convertedJSON is NSDictionary)
        XCTAssertEqual(convertedJSON as! NSDictionary, JSON)
    }

    func testSessionCreationWithOptionals() {
        let JSON: NSDictionary = ["title": "Title", "description": "Description", "sectionId": "1234", "_links": ["viaplay:sections": []]]
        let session = Session.from(JSON)

        XCTAssertNotNil(session)
        XCTAssertEqual(session?.title, "Title")
        XCTAssertEqual(session?.descSession, "Description")
        XCTAssertEqual(session?.sessionId, "1234")
        XCTAssertNotNil(session?.sessionItem)
        XCTAssertEqual(session?.sessionItem?.count, 0)

        let convertedJSON = session.toJSON()

        XCTAssertNotNil(convertedJSON)
        XCTAssertTrue(convertedJSON is NSDictionary)
        XCTAssertEqual(convertedJSON as! NSDictionary, JSON)
    }
}
