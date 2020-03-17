//
//  BaseViewModel.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Moya

class BaseViewModel: NSObject { // swiftlint:disable:this final_class
    
    let error = ErrorTracker()
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    
    override init() {
        super.init()
        
        error
            .asObservable()
            .subscribe(onNext: { (error) in
                if let error = error as? AppError {
                    AppHelper.showMessage(title: "Error", message: error.localizedDescription)
                } else if let error = error as? RxSwift.RxError {
                    switch error {
                    case .timeout:
                        AppHelper.showMessage(title: "Error", message: "Api Timeout")
                    default:
                        AppHelper.showMessage(title: "Error", message: "Unknown RxSwift error occurred")
                    }
                } else if let error = error as? Moya.MoyaError {
                    switch error {
                    case .objectMapping(_, let response), .jsonMapping(let response), .statusCode(let response):
                        if let errorResponse = try? response.map(ErrorResponse.self),
                            let message = errorResponse.message {
                                AppHelper.showMessage(title: "Error", message: message)
                        } else {
                            AppHelper.showMessage(title: "Error", message: "Map Data Error of bad StatusCode")
                        }
                    default:
                        AppHelper.showMessage(title: "Error", message: "Unknown Moya error occurred")
                    }
                } else {
                    AppHelper.showMessage(title: "Error", message: error.localizedDescription)
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    deinit {
        if Configs.share.logDeinitEnabled {
           LogInfo("\(type(of: self)): Deinited")
        }
    }
    
}
