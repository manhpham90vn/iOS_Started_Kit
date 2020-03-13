//
//  LibsManager.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import Foundation
import XCGLogger
import Then
import NSObject_Rx
import Reusable
import Validator

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
