//
//  BaseViewController.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {
    
    let isLoading = BehaviorRelay(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading
            .asDriver()
            .distinctUntilChanged()
            .drive(SVProgressHUD.rx.isAnimating)
            .disposed(by: rx.disposeBag)
    }
    
    deinit {
        if Configs.share.logDeinitEnabled {
           LogInfo("\(type(of: self)): Deinited")
        }
    }
    
}
