//
//  MenuRepositoryType.swift
//  MyApp
//
//  Created by Manh Pham on 3/15/20.
//

protocol MenuRepositoryType {
    
    func listMenu(date: String) -> Single<ObjectResponse<Menu>>
    
}

struct MenuRepository: MenuRepositoryType {
    
    func listMenu(date: String) -> Single<ObjectResponse<Menu>> {
        return ApiConnection.share.listMenu(date: date)
    }
    
}
