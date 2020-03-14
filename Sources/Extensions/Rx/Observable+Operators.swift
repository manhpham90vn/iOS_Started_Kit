//
//  Observable+Operators.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

extension ObservableType {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }

}
