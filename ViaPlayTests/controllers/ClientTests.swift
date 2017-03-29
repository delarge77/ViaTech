//
//  ConnectionControllerTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 22/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
import OHHTTPStubs
import UIKit
@testable import ViaPlay

class ClientTests: XCTestCase {
    
    func testConnection() {
        
        let expec = expectation(description: "")
        
        Client.shared.session(url: nil) { session in
            XCTAssertNotNil(session, "must not be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testReturnsSessionWhenResponseStatusIs200() {

        let expec = expectation(description: "")

        stub(condition: isHost("content.viaplay.se")) { session in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("sessionItens.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }

        Client.shared.session(url: nil) { session in
            XCTAssertNotNil(session, "must be nil")
            expec.fulfill()
        }

        waitForExpectations(timeout: 15) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testReturnsNilWhenResponseStatusIsNot200() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { session in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:404, headers:nil)
        }
        
        Client.shared.session(url: nil) { session in
            XCTAssertNil(session, "must be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }

    func testReturnsNilWhenResponseStatusIs200AndResponseObjectIsNotADictionary() {
        let expec = expectation(description: "")

        stub(condition: isHost("content.viaplay.se")) { session in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:200, headers:nil)
        }

        Client.shared.session(url: nil) { session in
            XCTAssertNil(session, "must be nil")
            expec.fulfill()
        }

        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        //remove all stubs on tear down
        OHHTTPStubs.removeAllStubs()
    }
}
