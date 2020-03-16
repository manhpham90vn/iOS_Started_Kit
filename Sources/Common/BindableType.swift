//
//  BindableType.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import UIKit

protocol BindableType: class {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
    
}

extension BindableType where Self: BaseViewController {
    
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
    
}
