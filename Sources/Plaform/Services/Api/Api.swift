//
//  Api.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Moya

protocol Api {
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>>
    func listMenu(date: String) -> Single<ObjectResponse<Menu>>
    
}

extension ApiConnection: Api {
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>> {
        return request(target: MultiTarget(ApiRouter.login(email: email, password: password)), type: Login.self)
    }
    
    func listMenu(date: String) -> Single<ObjectResponse<Menu>> {
        return request(target: MultiTarget(ApiRouter.listMenu(date: date)), type: Menu.self)
    }
    
}
