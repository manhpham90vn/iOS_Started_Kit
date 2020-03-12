//
//  ViewModelType.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
