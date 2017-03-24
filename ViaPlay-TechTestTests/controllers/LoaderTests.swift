//
//  LoaderTests.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 23/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import XCTest
@testable import ViaPlay_TechTest

class LoaderTests: XCTestCase {
    
    func testLoadProvideWithWrongURL(){
        Loader.shared.session(url: URL(string: "")) { session in
            XCTAssertNil(session, "must be nil")
        }
    }
    
}
