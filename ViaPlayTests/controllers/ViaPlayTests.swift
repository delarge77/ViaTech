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
@testable import ViaPlay

class ViaPlayTests: XCTestCase {
    
    func testMustLoadWebContentWithNetworkConnection() {
        
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { request in
            let json = ["title": "Title", "description": "Description"]
            return OHHTTPStubsResponse(jsonObject: json, statusCode: 200, headers: nil)
        }

        let url = URL(string: "https://content.viaplay.se/iphone-se")!
        let session = Session(title: "Cached Title", descSession: "Cached Description", sessionId: nil, sessionItem: nil)
        URLCache.shared.cacheSession(session: session, url: url)
        
        ViaPlay.shared.session(url: nil) { session in
            XCTAssertNotNil(session)
            XCTAssertEqual(session?.title, "Title")
            XCTAssertEqual(session?.descSession, "Description")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testMustLoadCachedContentWithoutNetworkConnection() {
        
        let expec = expectation(description: "")
        
        stub(condition: isHost("content.viaplay.se")) { session in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue),
                userInfo: nil
            )
            return OHHTTPStubsResponse(error: error)
        }

        let url = URL(string: "https://content.viaplay.se/iphone-se")!
        let session = Session(title: "Cached Title", descSession: "Cached Description", sessionId: nil, sessionItem: nil)
        URLCache.shared.cacheSession(session: session, url: url)

        ViaPlay.shared.session(url: url) { session in
            XCTAssertNotNil(session)
            XCTAssertEqual(session?.title, "Cached Title")
            XCTAssertEqual(session?.descSession, "Cached Description")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    override func tearDown() {
        super.tearDown()

        OHHTTPStubs.removeAllStubs()
    }
    
}
