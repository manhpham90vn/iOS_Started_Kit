//
//  LoginViewModel.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

final class LoginViewModel: BaseViewModel {
    
    let navigator: LoginNavigatorType
    let useCase: LoginUseCaseType
    
    init(navigator: LoginNavigatorType, useCase: LoginUseCaseType) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
}

// MARK: - ViewModelType
extension LoginViewModel: ViewModelType {
    struct Input {
        let username: Driver<String>
        let password: Driver<String>
        let trigger: Driver<Void>
    }

    struct Output {
        let response: Driver<Void>
        let validateEmail: Driver<ValidationResult>
        let validatePassword: Driver<ValidationResult>
    }

    func transform(_ input: Input) -> Output {
        
        let validateUsername = input.username.map({ self.useCase.validate(username: $0) })
        let validatePassword = input.password.map({ self.useCase.validate(password: $0) })
        let isValidateEmail = validateUsername.map({ $0.isValid })
        let isValidatePassword = validatePassword.map({ $0.isValid })
        let isValidate = Driver
                                .combineLatest(isValidateEmail,
                                               isValidatePassword) { $0 && $1 }
                
        let triggerValidateEmail = input
                                .trigger
                                .withLatestFrom(validateUsername)
        
        let triggerValidatePassword = input
                                .trigger
                                .withLatestFrom(validatePassword)
                                .asObservable()
                                .skipUntil(isValidateEmail.asObservable().filter({ $0 == true }))
                                .asDriverOnErrorJustComplete()
        
        let isLoginEnabled = Driver.combineLatest(isValidate, loading.asDriver().not()) { $0 && $1 }
        
        let response = input
            .trigger
            .withLatestFrom(isLoginEnabled)
            .filter({ $0 == true })
            .withLatestFrom(Driver.combineLatest(input.username, input.password))
            .map({ AppHelper.base64Encode(value: "\($0):\($1)") })
            .do(onNext: { (token) in
                AuthManager.share.token = token
            })
            .flatMapLatest({ [weak self] _ -> Driver<User> in
                guard let self = self else { return Driver.empty() }
                return self.useCase.login()
                    .trackError(self.error)
                    .trackActivity(self.loading)
                    .asDriverOnErrorJustComplete()
            })
            .do(onNext: { (user) in
                AuthManager.share.user = user
            })
            .mapToVoid()
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigator.toEvent()
            })

        return Output(response: response,
                      validateEmail: triggerValidateEmail,
                      validatePassword: triggerValidatePassword)
    }
}
