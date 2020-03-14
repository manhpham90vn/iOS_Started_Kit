//
//  ArrayResponse.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class ArrayResponse<T: Codable>: Codable {
    
    var code: Int?
    var message: String?
    var data: [T]?
         
    enum CodingKeys: String, CodingKey {
        case code    =  "code"
        case message =  "message"
        case data    =  "data"
    }
    
    func isSuccess() -> Bool {
        return code == 200
    }
    
}

extension ArrayResponse: CustomStringConvertible {
    
    var description: String {
        return AppHelper.convert(self)
    }
    
}
