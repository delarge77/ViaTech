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
@testable import ViaPlay_TechTest
import Mapper

class SessionTests: XCTestCase {
    
    func testSessionObjectWithError(){
        
        guard let path = OHPathForFile("session.json", type(of: self)) else {
            XCTFail()
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else {
            XCTFail()
            return
        }
        
        guard let JSON = try? JSONSerialization.jsonObject(with: data, options: []) else {
            XCTFail()
            return
        }
        
        guard let dict = JSON as? NSDictionary else {
            XCTFail()
            return
        }
        
        let session = Session.from(dict)
        
        XCTAssertNotNil(session, "Session could not be nil")
        XCTAssertTrue(session?.sessionItem?.count == 6, "Session must have 6 sessionItem in this fixture")
        
    }
}
