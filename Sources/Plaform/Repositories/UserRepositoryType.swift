//
//  UserRepositoryType.swift
//  MyApp
//
//  Created by Manh Pham on 3/15/20.
//

protocol UserRepositoryType {
    func login() -> Single<User>
}

struct UserRepository: UserRepositoryType {
    
    func login() -> Single<User> {
        return ApiConnection.share.login()
    }
    
}
