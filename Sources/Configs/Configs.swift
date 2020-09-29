//
//  Configs.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class Configs {
    
    static let share = Configs()
    
    let baseUrl: String
    
    let apiTimeOut = RxTimeInterval.seconds(10)
    let loggingEnabled = true
    let logResourcesCountEnabled = false
    let logDeinitEnabled = false
    
    private init() {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Can't find file Info.plist")
        }
        guard let config = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            fatalError("Can't get data in Info.plist")
        }
        guard let baseUrl = config["BaseUrl"] as? String else {
            fatalError("Can't parse BaseURL")
        }
        
        self.baseUrl = baseUrl
    }
    
}
