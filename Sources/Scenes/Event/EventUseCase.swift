//
//  EventUseCase.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

protocol EventUseCaseType {

    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
    
}

struct EventUseCase: EventUseCaseType {
    
    let repository: EventRepositoryType
    
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]> {
        return repository.userReceivedEvents(username: username, page: page)
    }
    
}
