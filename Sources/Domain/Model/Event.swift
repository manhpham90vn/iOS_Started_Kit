//
//  Event.swift
//  MyApp
//
//  Created by Manh Pham on 3/17/20.
//

import Foundation

final class Event: Codable {
    
    var id: String?
    var type: String?
    var actor: User?
    var repo: Repository?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case actor = "actor"
        case repo = "repo"
    }
    
}

extension Event: IdentifiableType {
        
    var identity: String {
        return id ?? ""
    }
    
}

extension Event: Equatable {
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
}
