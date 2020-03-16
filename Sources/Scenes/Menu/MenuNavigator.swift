//
//  MenuNavigator.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol MenuNavigatorType {

}

struct MenuNavigator: MenuNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: BaseNavigationController
}
