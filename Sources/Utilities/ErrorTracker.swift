//
//  ErrorTracker.swift
//  MyApp
//
//  Created by Manh Pham on 3/14/20.
//

import Foundation

enum AppError: LocalizedError {
    
    case customErrror(message: String)
    
    var localizedDescription: String {
        switch self {
        case .customErrror(let message):
            return message
        }
    }
    
}

final class ErrorTracker: SharedSequenceConvertibleType {
    typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<Error>()

    func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable().do(onError: onError)
    }

    func trackError<O: ObservableConvertibleType, T: Codable>(from source: O, type: T.Type) -> Observable<O.Element> {
        return source.asObservable().do(onNext: { (element) in
            if let element = element as? ObjectResponse<T>, !element.isSuccess(), let message = element.message {
                self.onError(message)
            }
        }, onError: { (error) in
            self.onError(error)
        })
    }
        
    func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _subject.asObservable().asDriverOnErrorJustComplete()
    }

    func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }

    private func onError(_ error: Error) {
        _subject.onNext(error)
    }

    private func onError(_ error: String) {
        let error = AppError.customErrror(message: error)
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    
    func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
    
    func trackError<T: Codable>(_ errorTracker: ErrorTracker, type: T.Type) -> Observable<Element> {
        return errorTracker.trackError(from: self, type: type)
    }
    
}
