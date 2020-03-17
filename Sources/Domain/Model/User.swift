//
//  User.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class User: Codable {
    
    var id: Double?
    var name: String?
    var login: String?
    var email: String?
    var avatar: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case login = "login"
        case email = "email"
        case avatar = "avatar_url"
        case url = "url"
    }
    
}
