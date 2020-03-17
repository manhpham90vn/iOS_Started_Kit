//
//  MenuUseCase.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol MenuUseCaseType {

    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
    
}

struct MenuUseCase: MenuUseCaseType {
    
    let repository: EventRepositoryType
    
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]> {
        return repository.userReceivedEvents(username: username, page: page)
    }
    
}
