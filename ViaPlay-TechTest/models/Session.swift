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

    let title: String
    let descSession: String
    let sessionId: String?
    let sessionItem: [SessionItem]?

    // MARK: - Deserialization
    init(map: Mapper) throws {
        try title = map.from("title")
        try descSession = map.from("description")
        sessionId = map.optionalFrom("sectionId")
        sessionItem = map.optionalFrom("_links.viaplay:sections") ?? []
    }
    
    init(title: String, descSession: String, sessionId: String?, sessionItem: [SessionItem]?) {
        self.title = title
        self.descSession = descSession
        self.sessionId = sessionId
        self.sessionItem = sessionItem
    }
}

extension Session: ReverseMappable {
    func toJSON() -> Any? {
        var result: [String: Any] = [
            "title": title,
            "description": descSession
        ]
        
        if let sessionId = sessionId {
            result["sectionId"] = sessionId
        }
        
        if let sessionItem = sessionItem?.toJSON() {
            result["_links"] = ["viaplay:sections": sessionItem]
        }
        
        return result
    }
}
