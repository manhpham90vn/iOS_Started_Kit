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
        case id = "id"
        case title = "tile"
        case price = "price"
        case image = "image"
        case createdAt = "created_at"
    }
    
}

extension Meal: CustomStringConvertible {
    
    var description: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }
        guard let jsonString = String(data: data, encoding: .utf8) else { return "" }
        return jsonString
    }
    
}
