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
    var avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case phone = "phone"
        case fullName = "full_name"
        case createdAt = "created_at"
        case avatar = "avatar"
    }
    
}

extension User: CustomStringConvertible {
    
    var description: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }
        guard let jsonString = String(data: data, encoding: .utf8) else { return "" }
        return jsonString
    }
    
}
