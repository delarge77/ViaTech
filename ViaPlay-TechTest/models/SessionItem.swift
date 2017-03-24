//
//  SessionItem.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 21/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit
import Mapper

private func removeDownloadableContent(object: Any?) throws -> URL {
    guard let fullurl = object as? String else {
        throw MapperError.convertibleError(value: object, type: String.self)
    }

    guard let formattedURL = URL(string: fullurl.replacingOccurrences(of: "{?dtg}", with: "")) else {
        throw MapperError.customError(field: nil, message: "Could not remove the string {?dtg}")
    }

    return formattedURL
}

struct SessionItem: Mappable {

    let href:URL
    let itemID:String
    let name:String
    let templated:Bool
    let itemTitle:String
    let itemType:String

    // MARK: - Deserialization
    init(map: Mapper) throws {
        try href = map.from("href", transformation: removeDownloadableContent)
        try itemID = map.from("id")
        try name = map.from("name")
        try templated = map.from("templated")
        try itemTitle = map.from("title")
        try itemType = map.from("type")
    }
}

extension SessionItem: ReverseMappable {
    func toJSON() -> Any? {
        return [
            "href": href.absoluteString,
            "id": itemID,
            "name": name,
            "templated": templated,
            "title": itemTitle,
            "type": itemType
        ]
    }
}
