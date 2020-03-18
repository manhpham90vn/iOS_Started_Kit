//
//  LoginAssembler.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit

protocol LoginAssembler {
    func resolve(navigationController: BaseNavigationController) -> LoginViewController
    func resolve(navigationController: BaseNavigationController) -> LoginViewModel
    func resolve(navigationController: BaseNavigationController) -> LoginNavigatorType
    func resolve() -> LoginUseCaseType
}

extension LoginAssembler {
    func resolve(navigationController: BaseNavigationController) -> LoginViewController {
        let vm: LoginViewModel = resolve(navigationController: navigationController)
        let vc = LoginViewController(viewModel: vm)
        return vc
    }

    func resolve(navigationController: BaseNavigationController) -> LoginViewModel {
        return LoginViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension LoginAssembler where Self: DefaultAssembler {
    func resolve(navigationController: BaseNavigationController) -> LoginNavigatorType {
        return LoginNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> LoginUseCaseType {
        return LoginUseCase(repository: resolve())
    }
}
