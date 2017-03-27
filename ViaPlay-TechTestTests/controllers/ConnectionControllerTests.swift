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
@testable import ViaPlay_TechTest

class ConnectionControllerTests: XCTestCase {
    
    func testConnection(){
        
        let expec = expectation(description: "")
        
        ConnectionController.shared.session(url: nil) { session in
            XCTAssertNotNil(session, "must not be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testDownNetworkConnection(){
        
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { session in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)

        }
        
        ConnectionController.shared.session(url: nil) { session in
            XCTAssertNil(session, "must not be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testBadNetworkConnection(){
        
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { session in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:200, headers:nil)
                            .requestTime(1.0, responseTime: 5.0)
        }
        
        ConnectionController.shared.session(url: nil) { session in
            XCTAssertNil(session, "must be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    func testBadRequestConnectionError() {
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { session in
            return OHHTTPStubsResponse(jsonObject:[], statusCode:404, headers:nil)
                .requestTime(1.0, responseTime: 5.0)
        }
        
        ConnectionController.shared.session(url: nil) { session in
            XCTAssertNil(session, "must be nil")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    //URL(string: "https://content.viaplay.se/iphone-se")!
    
    override func tearDown() {
        super.tearDown()
        
        //remove all stubs on tear down
        OHHTTPStubs.removeAllStubs()
    }
}
