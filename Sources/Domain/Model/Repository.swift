//
//  Repository.swift
//  MyApp
//
//  Created by Manh Pham on 3/17/20.
//

import Foundation

final class Repository: Codable {
    
    var id: Double?
    var name: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case url = "url"
    }
    
}
