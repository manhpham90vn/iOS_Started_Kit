//
//  LibsManager.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import Foundation
import XCGLogger

class LibsManager {

    static let shared = LibsManager()
    private init() {}
    
    func setupLibs(with window: UIWindow?) {
        let libsManager = LibsManager.shared
        libsManager.setupLoger()
    }
    
    private func setupLoger() {
        LoggerSetup()
    }
    
}
