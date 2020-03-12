//
//  BindableType.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import Foundation
import UIKit
import RxSwift

protocol BindableType: class {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
    
}

extension BindableType where Self: UIViewController {
    
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
    
}
