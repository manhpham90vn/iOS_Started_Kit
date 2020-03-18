//
//  LoginNavigator.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit

protocol LoginNavigatorType {
    func toEvent()
}

struct LoginNavigator: LoginNavigatorType {
        
    unowned let assembler: Assembler
    unowned let navigationController: BaseNavigationController
    
    func toEvent() {
        let vc: EventViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
