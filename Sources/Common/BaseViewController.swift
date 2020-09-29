//
//  BaseViewController.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController { // swiftlint:disable:this final_class
    
    let isLoading = PublishSubject<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading
            .asDriverOnErrorJustComplete()
            .drive(SVProgressHUD.rx.isAnimating)
            .disposed(by: rx.disposeBag)
    }
    
    deinit {
        if Configs.share.logDeinitEnabled {
           LogInfo("\(type(of: self)): Deinited")
        }
    }
    
}
