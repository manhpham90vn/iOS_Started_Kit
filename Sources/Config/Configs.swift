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
    
    let baseUrl = "http://149.28.137.201/api/"
    let apiTimeOut = RxTimeInterval.seconds(10)
    let loggingEnabled = false
    let logResourcesCountEnabled = false
    let logDeinitEnabled = false
    
}
