//
//  MenuUseCase.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol MenuUseCaseType {

    func listMenu(date: String) -> Single<ObjectResponse<Menu>>
    
}

struct MenuUseCase: MenuUseCaseType {
    
    let repository: MenuRepositoryType
    
    func listMenu(date: String) -> Single<ObjectResponse<Menu>> {
        repository.listMenu(date: date)
    }
    
}
