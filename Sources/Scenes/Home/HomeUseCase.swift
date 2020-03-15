//
//  HomeUseCase.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol HomeUseCaseType {
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>>
    func validate(email: String) -> ValidationResult
    func validate(password: String) -> ValidationResult
    
}

struct HomeUseCase: HomeUseCaseType {
    
    let repository: UserRepositoryType
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>> {
        repository.login(email: email, password: password)
    }
    
    func validate(email: String) -> ValidationResult {
        var rule = ValidationRuleSet<String>()
        let minLengthRule = ValidationRuleLength(min: 1,
                                                 error: LoginValidationError.emailMinLength)
        let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.simple,
                                              error: LoginValidationError.emailFormat)
        rule.add(rule: minLengthRule)
        rule.add(rule: emailRule)
        
        return email.validate(rules: rule)
    }
    
    func validate(password: String) -> ValidationResult {
        let minLengthRule = ValidationRuleLength(min: 1, error: LoginValidationError.passwordMinLength)
        return password.validate(rule: minLengthRule)
    }
    
}
