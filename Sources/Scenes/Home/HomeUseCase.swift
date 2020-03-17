//
//  HomeUseCase.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol HomeUseCaseType {
    
    func login() -> Single<User>
    func validate(username: String) -> ValidationResult
    func validate(password: String) -> ValidationResult
    
}

struct HomeUseCase: HomeUseCaseType {
    
    let repository: UserRepositoryType
    
    func login() -> Single<User> {
        repository.login()
    }
    
    func validate(username: String) -> ValidationResult {
        let minLengthRule = ValidationRuleLength(min: 1, error: LoginValidationError.usernameMinLength)
        return username.validate(rule: minLengthRule)
    }
    
    func validate(password: String) -> ValidationResult {
        let minLengthRule = ValidationRuleLength(min: 1, error: LoginValidationError.passwordMinLength)
        return password.validate(rule: minLengthRule)
    }
    
}
