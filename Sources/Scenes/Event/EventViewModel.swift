//
//  EventViewModel.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

final class EventViewModel: BaseViewModel {
    let navigator: EventNavigatorType
    let useCase: EventUseCaseType
    
    init(navigator: EventNavigatorType, useCase: EventUseCaseType) {
        self.navigator = navigator
        self.useCase = useCase
    }
}

// MARK: - ViewModelType
extension EventViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let refreshTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let logOutTrigger: Driver<Void>
    }

    struct Output {
        let items: Driver<[DefaultSection]>
        let isEnableLoadMore: Driver<Bool>
    }

    func transform(_ input: Input) -> Output {
        
        let elements = BehaviorRelay<[DefaultSection]>(value: [])
        let isEnableLoadMore = PublishSubject<Bool>()
        
        input
            .loadTrigger
            .flatMapLatest({ [weak self] () -> Driver<[Event]> in
                guard let self = self else { return Driver.just([]) }
                self.currentPage = 1
                return self.request().asDriverOnErrorJustComplete()
            })
            .map { (events) -> [DefaultSection] in
                return [DefaultSection(id: 1, items: events)]
            }
            .do(onNext: { (items) in
                elements.accept(items)
            })
            .drive()
            .disposed(by: rx.disposeBag)
        
        input
            .refreshTrigger
            .flatMapLatest({ [weak self] () -> Driver<[Event]> in
                guard let self = self else { return Driver.just([]) }
                self.currentPage = 1
                return self.request()
                    .trackActivity(self.headerLoading)
                    .asDriverOnErrorJustComplete()
            })
            .map { (events) -> [DefaultSection] in
                return [DefaultSection(id: 1, items: events)]
            }
            .do(onNext: { (items) in
                isEnableLoadMore.onNext(true)
                elements.accept(items)
            })
            .drive()
            .disposed(by: rx.disposeBag)
        
        input
            .loadMoreTrigger
            .flatMapLatest({ [weak self] () -> Driver<[Event]> in
                guard let self = self else { return Driver.just([]) }
                self.currentPage += 1
                return self.request()
                    .trackActivity(self.footerLoading)
                    .asDriverOnErrorJustComplete()
            })
            .map({ (events) -> [DefaultSection] in
                if events.isEmpty || elements.value.first?.items.count ?? 0 >= 100 {
                    isEnableLoadMore.onNext(false)
                    return elements.value
                } else {
                    isEnableLoadMore.onNext(true)
                    var currentElements = elements.value.first?.items ?? []
                    currentElements.append(contentsOf: events)
                    return [DefaultSection(id: 1, items: currentElements)]
                }
            })
            .do(onNext: { (items) in
                elements.accept(items)
            })
            .drive()
            .disposed(by: rx.disposeBag)
        
        input
            .logOutTrigger
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                AuthManager.share.onLogOut()
                self.navigator.logOut()
            })
            .drive()
            .disposed(by: rx.disposeBag)
        
        return Output(items: elements.asDriver(),
                      isEnableLoadMore: isEnableLoadMore.asDriverOnErrorJustComplete())
    }
}

extension EventViewModel {
    
    func request() -> Observable<[Event]> {
        return self
            .useCase
            .userReceivedEvents(username: AuthManager.share.user?.login ?? "", page: currentPage)
            .trackError(self.error)
            .trackActivity(self.loading)
    }
    
}
