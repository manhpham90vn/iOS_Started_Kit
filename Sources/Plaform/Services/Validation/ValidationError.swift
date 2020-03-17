//
//  ValidationError.swift
//  MyApp
//
//  Created by Manh Pham on 3/15/20.
//

import Foundation

enum LoginValidationError: ValidationError {
    case usernameMinLength
    case passwordMinLength
    
    var message: String {
        switch self {
        case .usernameMinLength:
            return "Please enter your username."
        case .passwordMinLength:
            return "Please enter your password."
        }
    }
}
