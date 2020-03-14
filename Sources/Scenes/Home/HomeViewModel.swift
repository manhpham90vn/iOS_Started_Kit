//
//  HomeViewModel.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

class HomeViewModel: BaseViewModel {
    
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
    
    init(navigator: HomeNavigatorType, useCase: HomeUseCaseType) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
}

// MARK: - ViewModelType
extension HomeViewModel: ViewModelType {
    struct Input {
        let email: Driver<String>
        let password: Driver<String>
        let trigger: Driver<Void>
    }

    struct Output {
        let response: Driver<ObjectResponse<Login>>
    }

    func transform(_ input: Input) -> Output {
        
        let response = input
            .trigger
            .withLatestFrom(Driver.combineLatest(input.email, input.password))
            .flatMapLatest({ [weak self] (email, password) -> Driver<ObjectResponse<Login>> in
                guard let self = self else { return Driver.empty() }
                    return ApiConnection.share.login(email: email, password: password)
                    .trackError(self.error, type: Login.self)
                    .trackActivity(self.loading)
                    .asDriverOnErrorJustComplete()
            })

        return Output(response: response)
    }
}
