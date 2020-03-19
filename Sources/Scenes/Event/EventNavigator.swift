//
//  EventNavigator.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol EventNavigatorType {

    func logOut()
    
}

struct EventNavigator: EventNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: BaseNavigationController
    
    func logOut() {
        navigationController.popViewController(animated: true)
    }
}
