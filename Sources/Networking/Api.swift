//
//  Api.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

protocol Api {
    
    func login(email: String, password: String) -> Single<ObjectResponse<User>>
    func listMenu(date: String) -> Single<ObjectResponse<Menu>>
    
}
