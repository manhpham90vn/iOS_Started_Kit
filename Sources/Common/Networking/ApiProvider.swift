//
//  ApiProvider.swift
//  MyApp
//
//  Created by Manh Pham on 3/27/20.
//

import Foundation
import Moya

final class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType]) {
        var plugins = plugins
        plugins.append(NetworkIndicatorPlugin.indicatorPlugin())
        if Configs.share.loggingEnabled {
            plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        }
        super.init(plugins: plugins)
    }
            
    func request(target: Target) -> Single<Response> {
        return connectedToInternet()
            .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self
                    .rx
                    .request(target)
                    .timeout(Configs.share.apiTimeOut, scheduler: MainScheduler.instance)
                    .filterSuccessfulStatusCodes()
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
        
}
