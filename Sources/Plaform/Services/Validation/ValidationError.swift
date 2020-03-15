//
//  ValidationError.swift
//  MyApp
//
//  Created by Manh Pham on 3/15/20.
//

import Foundation

enum LoginValidationError: ValidationError {
    case emailMinLength
    case emailFormat
    case passwordMinLength
    
    var message: String {
        switch self {
        case .emailMinLength:
            return "Please enter your email."
        case .emailFormat:
            return "Please check your email format."
        case .passwordMinLength:
            return "Please enter your password."
        }
    }
}
