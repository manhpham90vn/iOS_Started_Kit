//
//  HomeViewModel.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

final class HomeViewModel: BaseViewModel {
    
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
        let isValidateEmail: Driver<ValidationResult>
        let isValidatePassword: Driver<ValidationResult>
    }

    func transform(_ input: Input) -> Output {
        
        let validateEmail = input.email.map({ self.useCase.validate(email: $0) })
        let validatePassword = input.password.map({ self.useCase.validate(password: $0) })
        let isValidateEmail = validateEmail.map({ $0.isValid })
        let isValidatePassword = validatePassword.map({ $0.isValid })
        let isValidate = Driver
                                .combineLatest(isValidateEmail,
                                               isValidatePassword)
                                .map({ $0 && $01 })
                
        let triggerValidateEmail = input
                                .trigger
                                .withLatestFrom(validateEmail)
        
        let triggerValidatePassword = input
                                .trigger
                                .withLatestFrom(validatePassword)
                                .asObservable()
                                .skipUntil(isValidateEmail.asObservable().filter({ $0 == true }))
                                .asDriverOnErrorJustComplete()
        
        let response = input
            .trigger
            .withLatestFrom(isValidate)
            .filter({ $0 == true })
            .withLatestFrom(Driver.combineLatest(input.email, input.password))
            .flatMapLatest({ [weak self] (email, password) -> Driver<ObjectResponse<Login>> in
                guard let self = self else { return Driver.empty() }
                return self.useCase.login(email: email, password: password)
                    .trackError(self.error, type: Login.self)
                    .trackActivity(self.loading)
                    .asDriverOnErrorJustComplete()
            })

        return Output(response: response,
                      isValidateEmail: triggerValidateEmail,
                      isValidatePassword: triggerValidatePassword)
    }
}
