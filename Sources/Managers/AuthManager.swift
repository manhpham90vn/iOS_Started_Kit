//
//  AuthManager.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

class AuthManager {
    
    static let share = AuthManager()
    private init() {}
    
    private let tokenKey = "tokenKey"
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            return userDefaults.value(forKey: tokenKey) as? String
        }
        set {
            return userDefaults.set(newValue, forKey: tokenKey)
        }
    }
    
}
