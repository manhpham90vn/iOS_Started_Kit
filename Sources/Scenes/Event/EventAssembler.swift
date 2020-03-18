//
//  EventAssembler.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit

protocol EventAssembler {
    func resolve(navigationController: BaseNavigationController) -> EventViewController
    func resolve(navigationController: BaseNavigationController) -> EventViewModel
    func resolve(navigationController: BaseNavigationController) -> EventNavigatorType
    func resolve() -> EventUseCaseType
}

extension EventAssembler {
    func resolve(navigationController: BaseNavigationController) -> EventViewController {
        let vm: EventViewModel = resolve(navigationController: navigationController)
        let vc = EventViewController(viewModel: vm)
        return vc
    }

    func resolve(navigationController: BaseNavigationController) -> EventViewModel {
        return EventViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension EventAssembler where Self: DefaultAssembler {
    func resolve(navigationController: BaseNavigationController) -> EventNavigatorType {
        return EventNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> EventUseCaseType {
        return EventUseCase(repository: resolve())
    }
}
