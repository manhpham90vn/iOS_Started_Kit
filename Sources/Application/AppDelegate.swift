//
//  AppDelegate.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Manh Pham. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let libManager = LibsManager.shared
        libManager.setupLibs(with: window)
        if Configs.share.logResourcesCountEnabled {
            logResourcesCount()
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let repo = UserRepository()
        let vm = LoginViewModel(repo: repo)
        let vc = LoginViewController(viewModel: vm)
        window?.rootViewController = BaseNavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
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
