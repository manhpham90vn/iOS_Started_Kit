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

extension Meal: IdentifiableType {
    
    typealias Identity = Int
    
    var identity: Int {
        return id ?? 0
    }
    
}

extension Meal: Equatable {
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.price == rhs.price
    }
    
}
