//
//  ApiRouter.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation
import Moya

enum ApiRouter {
    case login(email: String, password: String)
    case listMenu(date: String)
}

extension ApiRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: Configs.share.baseUrl)! // swiftlint:disable:this force_unwrapping
    }
    
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .listMenu:
            return "meals/get-menu"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .listMenu:
            return .get
        }
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
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .login(let email, let password): // swiftlint:disable:this pattern_matching_keywords
            params["email"] = email
            params["password"] = password
        case .listMenu(let date):
            params["date"] = date
        }
        return params
    }
    
}
