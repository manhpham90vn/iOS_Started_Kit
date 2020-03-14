//
//  HomeAssembler.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit

protocol HomeAssembler {
    func resolve(navigationController: BaseNavigationController) -> HomeViewController
    func resolve(navigationController: BaseNavigationController) -> HomeViewModel
    func resolve(navigationController: BaseNavigationController) -> HomeNavigatorType
    func resolve() -> HomeUseCaseType
}

extension HomeAssembler {
    func resolve(navigationController: BaseNavigationController) -> HomeViewController {
        let vc = HomeViewController.instantiate()
        let vm: HomeViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: BaseNavigationController) -> HomeViewModel {
        return HomeViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension HomeAssembler where Self: DefaultAssembler {
    func resolve(navigationController: BaseNavigationController) -> HomeNavigatorType {
        return HomeNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> HomeUseCaseType {
        return HomeUseCase()
    }
}
