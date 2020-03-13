//
//  AppNavigator.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import UIKit

protocol AppNavigatorType {
    func toHome()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toHome() {
        let nav = UINavigationController()
        let vc: HomeViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers = [vc]
        window.rootViewController = nav
    }
    
}
