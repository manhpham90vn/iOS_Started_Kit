//
//  Menu.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class Menu: Codable {
    
    var id: Int?
    var title: String?
    var meals: [Meal]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "tile"
        case meals = "meals"
    }
    
}

extension Menu: CustomStringConvertible {
    
    var description: String {
        return AppHelper.convert(self)
    }
    
}
