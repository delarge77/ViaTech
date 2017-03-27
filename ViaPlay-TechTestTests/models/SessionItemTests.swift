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
@testable import ViaPlay_TechTest

class SessionItemTests: XCTestCase {
 
    func testShouldFailConvetingSessionItemWithInvalidValue() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("sessionItens.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        Loader.shared.session(url: nil) { session in
            XCTAssertEqual(session?.sessionItem?.count, 0, "Value must be equals")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testShouldFailConvetingSessionItemWithMissingParameter() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("sessionItem.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        Loader.shared.session(url: nil) { session in
            XCTAssertEqual(session?.sessionItem?.count, 0, "Value must be equals")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
}
