//
//  BindableType.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import UIKit

protocol BindableType: class {
    
    associatedtype ViewModel: ViewModelType
    
    var viewModel: ViewModel { get set }
    
    init(viewModel: Self.ViewModel)
    
    func bindViewModel()
    
}
