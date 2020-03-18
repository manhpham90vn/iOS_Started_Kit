//
//  AppNavigator.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import UIKit

protocol AppNavigatorType {
    func toLogin()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toLogin() {
        let nav = BaseNavigationController()
        let vc: LoginViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers = [vc]
        window.rootViewController = nav
    }
    
}
