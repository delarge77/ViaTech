//
//  URLCache+Cache.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 21/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

extension URLCache : Cache {
    func session(url: URL?, completion: @escaping (Session?) -> Void) {
        let request = URLRequest(url: url ?? defaultURL)

        // Cache does not exists for given request
        guard let response = cachedResponse(for: request) else {
            completion(nil)
            return
        }

        // Cached response data is not JSON
        guard let JSON = try? JSONSerialization.jsonObject(with: response.data, options: []) else {
            completion(nil)
            return
        }

        // JSON value is not a NSDictionary
        guard let dict = JSON as? NSDictionary else {
            completion(nil)
            return
        }

        let session = Session.from(dict)
        completion(session)
    }

    func cacheSession(session: Session, url: URL) {
        // It is safe to force unwrap here
        let JSON = session.toJSON()!
        if let data = try? JSONSerialization.data(withJSONObject: JSON, options: []) {
            let request = URLRequest(url: url)
            let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
            let cache = CachedURLResponse(response: response, data: data)
            storeCachedResponse(cache, for: request)
        }
    }
}
