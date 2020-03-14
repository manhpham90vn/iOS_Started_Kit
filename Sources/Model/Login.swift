//
//  Login.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

import Foundation

class Login: Codable {
    
    var accessToken: String?
    var profile: User?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case profile = "profile"
    }
    
}

extension Login: CustomStringConvertible {
    
    var description: String {
        return AppHelper.convert(self)
    }
    
}
