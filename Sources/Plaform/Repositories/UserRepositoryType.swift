//
//  UserRepositoryType.swift
//  MyApp
//
//  Created by Manh Pham on 3/15/20.
//

protocol UserRepositoryType {
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>>
    
}

struct UserRepository: UserRepositoryType {
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>> {
        return ApiConnection.share.login(email: email, password: password)
    }
    
}
