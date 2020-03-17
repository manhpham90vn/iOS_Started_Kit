//
//  MenuViewModel.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

final class MenuViewModel: BaseViewModel {
    let navigator: MenuNavigatorType
    let useCase: MenuUseCaseType
    
    init(navigator: MenuNavigatorType, useCase: MenuUseCaseType) {
        self.navigator = navigator
        self.useCase = useCase
    }
}

// MARK: - ViewModelType
extension MenuViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let refreshTrigger: Driver<Void>
    }

    struct Output {
        let items: Driver<[Event]>
    }

    func transform(_ input: Input) -> Output {
        
        let trigger = Driver.merge(input.loadTrigger, input.refreshTrigger)
           
        let items = trigger
            .flatMapLatest({ [weak self] _ -> Driver<[Event]> in
                guard let self = self else { return Driver.empty() }
                return self.useCase
                    .userReceivedEvents(username: AuthManager.share.user?.login ?? "", page: 1)
                    .trackError(self.error)
                    .trackActivity(self.loading)
                    .trackActivity(self.headerLoading)
                    .asDriverOnErrorJustComplete()
            })
        
        return Output(items: items)
    }
}
