//
//  RepositoriesAssembler.swift
//  MyApp
//
//  Created by Manh Pham on 3/15/20.
//

protocol RepositoriesAssembler {
    func resolve() -> UserRepositoryType
    func resolve() -> MenuRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    
    func resolve() -> UserRepositoryType {
        return UserRepository()
    }
    
    func resolve() -> MenuRepositoryType {
        return MenuRepository()
    }
    
}
