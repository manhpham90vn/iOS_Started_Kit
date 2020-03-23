//
//  LibsManager.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import Foundation
import XCGLogger
import NSObject_Rx
import Toast_Swift // cocoapods
//import ToastSwiftFramework // carthage

final class LibsManager {

    static let shared = LibsManager()
    
    private init() {}
    
    func setupLibs(with window: UIWindow?) {
        let libsManager = LibsManager.shared
        libsManager.setupLoger()
        libsManager.setupToast()
    }
    
    private func setupLoger() {
        LoggerSetup()
    }
    
    func setupToast() {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.position = .top
        var style = ToastStyle()
        style.backgroundColor = .red
        style.messageColor = .white
        style.imageSize = CGSize(width: 20, height: 20)
        ToastManager.shared.style = style
    }
    
}
