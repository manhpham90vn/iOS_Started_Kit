//
//  BaseViewModel.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

class BaseViewModel: NSObject {
    
    let error = ErrorTracker()
    let loading = ActivityIndicator()
    
    override init() {
        super.init()
        
        error
            .asObservable()
            .subscribe(onNext: { (error) in
                if let error = error as? AppError {
                    AppHelper.showMessage(title: "Error", message: error.localizedDescription)
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
