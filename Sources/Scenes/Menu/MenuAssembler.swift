//
//  MenuAssembler.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit

protocol MenuAssembler {
    func resolve(navigationController: BaseNavigationController) -> MenuViewController
    func resolve(navigationController: BaseNavigationController) -> MenuViewModel
    func resolve(navigationController: BaseNavigationController) -> MenuNavigatorType
    func resolve() -> MenuUseCaseType
}

extension MenuAssembler {
    func resolve(navigationController: BaseNavigationController) -> MenuViewController {
        let vm: MenuViewModel = resolve(navigationController: navigationController)
        let vc = MenuViewController(viewModel: vm)
        return vc
    }

    func resolve(navigationController: BaseNavigationController) -> MenuViewModel {
        return MenuViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension MenuAssembler where Self: DefaultAssembler {
    func resolve(navigationController: BaseNavigationController) -> MenuNavigatorType {
        return MenuNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> MenuUseCaseType {
        return MenuUseCase(repository: resolve())
    }
}
