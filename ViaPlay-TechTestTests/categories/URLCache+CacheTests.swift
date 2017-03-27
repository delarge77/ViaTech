//
//  URLCache+CacheTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 23/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
import Foundation
import OHHTTPStubs
@testable import ViaPlay_TechTest

class URLCache_CacheTests: XCTestCase {
    
    let url = URL(string: "https://www.apple.com")!
    var session: Session!
    
    override func setUp() {
        let JSON = ["title": "Ttitle", "description": "Description"] as NSDictionary
        session = Session.from(JSON)
    }
    
    func testWritesSessionToCache() {
        let cache = URLCache()
        cache.cacheSession(session: session, url: url)
        
        let request = URLRequest(url: url)
        let response = cache.cachedResponse(for: request)
        XCTAssertNotNil(response)
    }
    
    func testReadsSessionFromCache() {
        let cache = URLCache()
        cache.cacheSession(session: session, url: url)
        
        cache.session(url: url) { session in
            XCTAssertNotNil(session)
        }
    }
    
    func testShouldFailRequestWithWrongURL() {
        let url = URL(string: "/")
        let cache = URLCache()
        cache.session(url: url!) { session in
            XCTAssertNil(session, "Return must be nil")
        }
    }
}
