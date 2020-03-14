//
//  ObjectResponse.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

class ObjectResponse<T: Codable>: Codable {
    
    var code: Int?
    var message: String?
    var data: T?
    
    func isSuccess() -> Bool {
        return code == 200
    }
            
}
