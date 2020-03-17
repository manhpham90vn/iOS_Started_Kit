//
//  Configs.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

final class Configs {
    
    static let share = Configs()
    
    private init() {}
    
    let baseUrl = "https://api.github.com"
    let apiTimeOut = RxTimeInterval.seconds(10)
    let loggingEnabled = true
    let logResourcesCountEnabled = false
    let logDeinitEnabled = false
    
}
