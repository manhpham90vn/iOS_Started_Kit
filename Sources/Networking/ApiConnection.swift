//
//  ApiConnection.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Moya

final class ApiConnection {
    
    static let share = ApiConnection()
    
    private init() {}
    
    private static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        if Configs.share.loggingEnabled == true {
            plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        }
        return plugins
    }
    
    private let provider = MoyaProvider<MultiTarget>(plugins: plugins).rx
        
    private func request<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ObjectResponse<T>> {
        return connectedToInternet()
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self.provider
                    .request(target)
                    .map(ObjectResponse<T>.self)
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    private func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ArrayResponse<T>> {
        return connectedToInternet()
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self.provider
                    .request(target)
                    .map(ArrayResponse<T>.self)
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
}

extension ApiConnection: Api {
    
    func login(email: String, password: String) -> Single<ObjectResponse<Login>> {
        return request(target: MultiTarget(ApiRouter.login(email: email, password: password)), type: Login.self)
    }
    
    func listMenu(date: String) -> Single<ObjectResponse<Menu>> {
        return request(target: MultiTarget(ApiRouter.listMenu(date: date)), type: Menu.self)
    }
    
}
