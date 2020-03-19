//
//  AuthManager.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class AuthManager {
    
    static let share = AuthManager()
    
    private init() {}
    
    private let tokenKey = "tokenKey"
    private let userKey = "userKey"
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            return userDefaults.value(forKey: tokenKey) as? String
        }
        set {
            return userDefaults.set(newValue, forKey: tokenKey)
        }
    }
    
    var user: User? {
        get {
            guard let data = userDefaults.value(forKey: userKey) as? Data else { return nil }
            guard let user = try? PropertyListDecoder().decode(User.self, from: data) else { return nil }
            return user
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: userKey)
        }
    }
    
    func onLogOut() {
        userDefaults.removeObject(forKey: tokenKey)
        userDefaults.removeObject(forKey: userKey)
    }
    
}
