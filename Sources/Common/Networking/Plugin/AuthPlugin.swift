//
//  AuthPlugin.swift
//  MyApp
//
//  Created by Manh Pham on 3/27/20.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let accessToken = AuthManager.share.token {
            request.addValue("Basic " + accessToken, forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
}
