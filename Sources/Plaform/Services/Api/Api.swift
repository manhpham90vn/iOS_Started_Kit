//
//  Api.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Moya

protocol Api {
    func login() -> Single<User>
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]>
}

extension ApiConnection: Api {

    func login() -> Single<User> {
        return request(target: MultiTarget(ApiRouter.login), type: User.self)
    }
    
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]> {
        return requestArray(target: MultiTarget(ApiRouter.userReceivedEvents(username: username,
                                                                             page: page)),
                            type: Event.self)
    }
    
}
