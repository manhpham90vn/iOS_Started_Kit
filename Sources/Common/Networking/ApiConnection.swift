//
//  ApiConnection.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Moya
import RxMoya // carthage

final class ApiConnection {
    
    static let share = ApiConnection()
    
    private let apiProvider: ApiProvider<MultiTarget>
    
    private init() {
        apiProvider = ApiProvider(plugins: [AuthPlugin()])
    }
    
}

extension ApiConnection {

    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Single<T> {
        return apiProvider.request(target: target).map(T.self)
    }

    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<[T]> {
        return apiProvider.request(target: target).map([T].self)
    }

    func requestBaseObject<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ObjectResponse<T>> {
        return apiProvider.request(target: target).map(ObjectResponse<T>.self)
    }

    func requestBaseArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ArrayResponse<T>> {
        return apiProvider.request(target: target).map(ArrayResponse<T>.self)
    }

}
