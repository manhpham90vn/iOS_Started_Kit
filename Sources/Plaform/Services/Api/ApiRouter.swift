//
//  ApiRouter.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation
import Moya

enum ApiRouter {
    case login
    case userReceivedEvents(username: String, page: Int)
}

extension ApiRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: Configs.share.baseUrl)! // swiftlint:disable:this force_unwrapping
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user"
        case .userReceivedEvents(let username, _):
            return "/user/\(username)/received_events"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return .requestPlain
    }
    
    var headers: [String: String]? {
        if let token = AuthManager.share.token {
            return ["Authorization": "Basic \(token)"]
        }
        return nil
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .login:
            return nil
        case .userReceivedEvents(_, let page):
            params["page"] = page
        }
        return params
    }
    
}
