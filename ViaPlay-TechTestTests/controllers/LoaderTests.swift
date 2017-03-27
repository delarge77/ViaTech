//
//  LoaderTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 23/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
import OHHTTPStubs
import UIKit

@testable import ViaPlay_TechTest

class LoaderTests: XCTestCase {
    
    func testLoader(){
        
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("session.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        Loader.shared.session(url: nil) { session in
            XCTAssertNotNil(session, "must not be nil")
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
