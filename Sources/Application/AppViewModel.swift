//
//  AppViewModel.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

class AppViewModel: BaseViewModel {
    
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
    
    init(navigator: AppNavigatorType, useCase: AppUseCaseType) {
        self.navigator = navigator
        self.useCase = useCase
    }
    
}

extension AppViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let toMain: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let toMain = input.loadTrigger
            .do(onNext: { _ in
                self.navigator.toHome()
            })
        
        return Output(toMain: toMain)
    }
    
}
