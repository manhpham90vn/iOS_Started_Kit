//
//  Configs.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

class Configs {
    
    static let share = Configs()
    private init() {}
    
    let baseUrl = "http://149.28.137.201/api/"
    let loggingEnabled = false
    let logResourcesCountEnabled = false
    
}
