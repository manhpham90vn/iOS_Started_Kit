//
//  EventRepositoryType.swift
//  MyApp
//
//  Created by Manh Pham on 3/15/20.
//

protocol EventRepositoryType {
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
}

struct EventRepository: EventRepositoryType {
    
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]> {
        return ApiConnection.share.userReceivedEvents(username: username, page: page)
    }
    
}
