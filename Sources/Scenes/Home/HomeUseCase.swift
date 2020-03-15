//
//  HomeUseCase.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol HomeUseCaseType {
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>>
    
}

struct HomeUseCase: HomeUseCaseType {
    
    let repository: UserRepositoryType
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>> {
        repository.login(email: email, password: password)
    }
    
}
