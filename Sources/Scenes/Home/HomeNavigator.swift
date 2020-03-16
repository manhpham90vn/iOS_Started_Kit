//
//  HomeNavigator.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit

protocol HomeNavigatorType {
    func toMenu()
}

struct HomeNavigator: HomeNavigatorType {
        
    unowned let assembler: Assembler
    unowned let navigationController: BaseNavigationController
    
    func toMenu() {
        let vc: MenuViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
