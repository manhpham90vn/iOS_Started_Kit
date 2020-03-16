//
//  Meal.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class Meal: Codable {
    
    var id: Int?
    var title: String?
    var price: Double?
    var image: String?
    var createdAt: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case image = "image"
        case createdAt = "created_at"
    }
    
}

extension Meal: CustomStringConvertible {
    
    var description: String {
        return AppHelper.convert(self)
    }
    
}
