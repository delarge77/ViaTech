//
//  Session.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 21/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit
import Mapper

struct Session: Mappable {

    let title:String?
    let descSession:String?
    let sessionId:String?
    let sessionItem:[SessionItem]?
    
    // MARK: - Deserialization
    init(map: Mapper) throws {
        try title = map.from("title")
        try descSession = map.from("description")
        sessionId = map.optionalFrom("sectionId")
        sessionItem = map.optionalFrom("_links.viaplay:sections") ?? []
    }
}
