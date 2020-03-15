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
    
}

extension ApiConnection {
    
    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ObjectResponse<T>> {
        return connectedToInternet()
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self.provider
                    .request(target)
                    .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
                    .filterSuccessfulStatusCodes()
                    .map(ObjectResponse<T>.self)
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<ArrayResponse<T>> {
        return connectedToInternet()
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self.provider
                    .request(target)
                    .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
                    .filterSuccessfulStatusCodes()
                    .map(ArrayResponse<T>.self)
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
}
