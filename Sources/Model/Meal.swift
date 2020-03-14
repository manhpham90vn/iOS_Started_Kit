//
//  Meal.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

class Meal: Codable {
    
    var id: Int?
    var title: String?
    var price: Double?
    var image: String?
    var createdAt: Double?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
    
}
