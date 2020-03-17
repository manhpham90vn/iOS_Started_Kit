//
//  HomeViewController.swift
//  My Project
//
//  Created by Manh Pham on 3/12/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit
import Reusable

final class HomeViewController: BaseViewController, BindableType {
        
    // MARK: - IBOutlets
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
    }
    
    // MARK: - Methods
    private func configView() {
        title = "Home"
    }

    func bindViewModel() {
        
        viewModel
            .loading
            .asDriver()
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
        
        let input = HomeViewModel.Input(username: emailTextField.rx.text.orEmpty.asDriver(),
                                        password: passwordTextField.rx.text.orEmpty.asDriver(),
                                        trigger: tapButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
    
        output
            .validateEmail
            .drive(emailValidationBinder)
            .disposed(by: rx.disposeBag)
        
        output
            .validatePassword
            .drive(passwordValidationBinder)
            .disposed(by: rx.disposeBag)
        
        output
            .response
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Binders
extension HomeViewController {
    var emailValidationBinder: Binder<ValidationResult> {
        return Binder(self) { vc, result in
            switch result {
            case .valid:
                break
            case let .invalid(errors):
                vc.view.makeToast(errors.map { $0.message }.joined(separator: "\n"))
            }
        }
    }
    
    var passwordValidationBinder: Binder<ValidationResult> {
        return Binder(self) { vc, result in
            switch result {
            case .valid:
                break
            case let .invalid(errors):
                vc.view.makeToast(errors.map { $0.message }.joined(separator: "\n"))
            }
        }
    }
}
