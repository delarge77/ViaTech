//
//  Provider.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 22/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

protocol Provider {
    var defaultURL: URL { get }
    func session(url: URL?, completion: @escaping (Session?) -> Void)
}

protocol Cache : Provider {
    func cacheSession(session: Session, url: URL)
}

extension Provider {
    var defaultURL: URL {
        return URL(string: "https://content.viaplay.se/iphone-se")!
    }
}
