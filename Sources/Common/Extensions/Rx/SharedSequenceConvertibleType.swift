//
//  SharedSequenceConvertibleType.swift
//  MyApp
//
//  Created by Manh Pham on 3/16/20.
//

extension SharedSequenceConvertibleType {
    
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
    
    func unwrap<Result>() -> SharedSequence<SharingStrategy, Result> where Element == Result? {
        return compactMap { $0 }
    }
    
}
