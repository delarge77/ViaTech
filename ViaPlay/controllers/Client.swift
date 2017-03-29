//
//  ConnectionController.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 21/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import UIKit
import Alamofire

struct Client {
    static let shared = Client()
}

extension Client: Provider {
    func session(url: URL?, completion: @escaping (Session?) -> Void) {
        let url = url ?? defaultURL
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        Alamofire.request(request).responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let JSON = response.result.value as? NSDictionary {
                        let session = Session.from(JSON)
                        completion(session)
                    } else {
                        completion(nil)
                    }
                default:
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
