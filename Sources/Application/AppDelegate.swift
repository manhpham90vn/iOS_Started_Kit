//
//  AppDelegate.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Manh Pham. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let libManager = LibsManager.shared
        libManager.setupLibs(with: window)
        
        logResourcesCount()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        
        return true
    }
    
}

extension AppDelegate {
    
    private func logResourcesCount() {
        #if DEBUG
        _ = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                LogDebug("Resource count \(RxSwift.Resources.total)")
            })
        #endif
    }
    
    
}
