//
//  ArrayResponse.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

class ArrayResponse<T: Codable>: Codable {
    
    var code: Int?
    var message: String?
    var data: [T]?
         
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
        case data = "data"
    }
    
    func isSuccess() -> Bool {
        return code == 200
    }
    
}

extension ArrayResponse: CustomStringConvertible {
    
    var description: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }
        guard let jsonString = String(data: data, encoding: .utf8) else { return "" }
        return jsonString
    }
    
}
