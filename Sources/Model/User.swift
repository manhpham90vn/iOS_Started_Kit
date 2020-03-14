//
//  User.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

class User: Codable {
    
    var id: Int?
    var email: String?
    var phone: String?
    var fullName: String?
    var createdAt: Double?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case createdAt = "created_at"
    }
    
}
