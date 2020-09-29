//
//  ErrorResponse.swift
//  MyApp
//
//  Created by Manh Pham on 3/17/20.
//

import Foundation

struct ErrorResponse: Codable {
    
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
}
