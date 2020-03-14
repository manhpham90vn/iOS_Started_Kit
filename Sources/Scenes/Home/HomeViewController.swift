//
//  HomeViewController.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit
import Reusable

final class HomeViewController: UIViewController, BindableType {
    
    let error = ErrorTracker()
    let loading = ActivityIndicator()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tapButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
        let test = tapButton
            .rx
            .tap
            .flatMapLatest({ ApiConnection.share.login(email: "test123@test.com", password: "123123") })
            .trackError(error, type: Login.self)
            .trackActivity(loading)
            .catchErrorJustComplete()
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        test
            .subscribe(onNext: { (response) in
                LogInfo(response.data?.accessToken)
            })
            .disposed(by: rx.disposeBag)
        
        test
            .subscribe(onNext: { (response) in
                LogInfo(response.data?.profile?.description)
            })
            .disposed(by: rx.disposeBag)
        
        error.asDriver().drive(onNext: { (error) in
            if let error = error as? AppError {
                LogError(error.localizedDescription)
            } else {
                LogError(error.localizedDescription)
            }
        }).disposed(by: rx.disposeBag)
        
        loading.asDriver().drive(onNext: { (loading) in
            LogDebug(loading)
        })
        .disposed(by: rx.disposeBag)
    }

    deinit {
        logDeinit()
    }
    
    // MARK: - Methods

    private func configView() {
        title = "Home"
    }

    func bindViewModel() {
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input)
    }
}
