//
//  URLCache+Cache.swift
//  ViaPlay-TechTest
//
//  Created by Leonardo Formaggio on 3/22/17.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

extension URLCache : Cache {
    func session(url: URL?, completion: @escaping (Session?) -> Void) {
        let request = URLRequest(url: url ?? defaultURL)

        guard let response = cachedResponse(for: request) else {
            completion(nil)
            return
        }

        guard let JSON = try? JSONSerialization.jsonObject(with: response.data, options: []) else {
            completion(nil)
            return
        }

        guard let dict = JSON as? NSDictionary else {
            completion(nil)
            return
        }

        let session = Session.from(dict)
        completion(session)
    }

    func cacheSession(session: Session, url: URL) {
        guard let JSON = try? NSDictionary.fromMap(session) else {
            return
        }

        guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: []) else {
            return
        }

        let request = URLRequest(url: url)
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let cache = CachedURLResponse(response: response, data: data)
        storeCachedResponse(cache, for: request)
    }
}
