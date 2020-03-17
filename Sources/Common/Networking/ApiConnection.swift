//
//  ApiConnection.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Moya
import RxMoya

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
    
    private func request(target: MultiTarget) -> Single<Response> {
        return connectedToInternet()
            .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self.provider
                    .request(target)
                    .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
                    .filterSuccessfulStatusCodes()
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
        
}

extension ApiConnection {
    
    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Single<T> {
        return request(target: target).map(T.self)
    }
    
    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<[T]> {
        return request(target: target).map([T].self)
    }
    
    func requestBaseObject<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ObjectResponse<T>> {
        return request(target: target).map(ObjectResponse<T>.self)
    }
    
    func requestBaseArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ArrayResponse<T>> {
        return request(target: target).map(ArrayResponse<T>.self)
    }
    
}
