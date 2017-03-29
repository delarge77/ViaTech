//
//  Loader.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 22/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

struct ViaPlay {
    static var shared = ViaPlay()
}

extension ViaPlay: Provider {
    func session(url: URL?, completion: @escaping (Session?) -> Void) {
        Client.shared.session(url: url) { session in
            if let session = session {
                URLCache.shared.cacheSession(session: session, url: url ?? self.defaultURL)
                completion(session)
            } else {
                URLCache.shared.session(url: url, completion: completion)
            }
        }
    }
}
