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
        let date: String
    }

    struct Output {
        let items: Driver<[Meal]>
    }

    func transform(_ input: Input) -> Output {
        
        let trigger = Driver.merge(input.loadTrigger, input.refreshTrigger)
           
        let items = trigger
            .flatMapLatest({ [weak self] _ -> Driver<ObjectResponse<Menu>> in
                guard let self = self else { return Driver.empty() }
                return self.useCase
                    .listMenu(date: input.date)
                    .trackError(self.error, type: Menu.self)
                    .trackActivity(self.loading)
                    .trackActivity(self.headerLoading)
                    .asDriverOnErrorJustComplete()
            })
            .map({ $0.data?.meals ?? [] })
        
        return Output(items: items)
    }
}
