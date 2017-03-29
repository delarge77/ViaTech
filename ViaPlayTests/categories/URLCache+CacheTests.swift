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
@testable import ViaPlay

extension URLCache {
    class func cache() -> URLCache {
        return URLCache(memoryCapacity: 1024, diskCapacity: 0, diskPath: nil)
    }
}

class URLCache_CacheTests: XCTestCase {
    let url = URL(string: "https://www.apple.com")!
    var session: Session!
    
    override func setUp() {
        super.setUp()

        let JSON = ["title": "Title", "description": "Description"] as NSDictionary
        session = Session.from(JSON)
    }
    
    func testWritesSessionToCache() {
        let cache = URLCache.cache()
        cache.cacheSession(session: session, url: url)
        
        let request = URLRequest(url: url)
        let response = cache.cachedResponse(for: request)
        XCTAssertNotNil(response)
    }
    
    func testReadsSessionFromCache() {
        let cache = URLCache.cache()
        cache.cacheSession(session: session, url: url)

        var response: Session?
        cache.session(url: url) { session in
            response = session
        }

        XCTAssertNotNil(response)
    }
    
    func testLoadCacheWithNullURL() {
        let cache = URLCache.cache()
        cache.cacheSession(session: session, url: cache.defaultURL)

        var response: Session?
        cache.session(url: nil) { session in
            response = session
        }

        XCTAssertNotNil(response, "Session could not be nil")
    }

    func testReturnsNilWhenThereIsNoCacheForTheGivenURL() {
        let cache = URLCache.cache()

        var response: Session?
        cache.session(url: url) { session in
            response = session
        }

        XCTAssertNil(response)
    }

    func testReturnsNilWhenCachedResponseIsNotJSON() {
        let cache = URLCache.cache()

        let data = "123".data(using: .utf8)!
        let request = URLRequest(url: url)
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 3, textEncodingName: nil)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)

        var value: Session?
        cache.session(url: url) { session in
            value = session
        }

        XCTAssertNil(value)
    }

    func testReturnsNilWhenCachedResponseIsNotDictionary() {
        let cache = URLCache.cache()

        let data = "[]".data(using: .utf8)!
        let request = URLRequest(url: url)
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 2, textEncodingName: nil)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)

        var value: Session?
        cache.session(url: url) { session in
            value = session
        }

        XCTAssertNil(value)
    }
}
