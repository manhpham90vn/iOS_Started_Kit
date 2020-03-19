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
    }

    struct Output {
        let items: Driver<[DefaultSection]>
        let noticeNoMoreData: Driver<Void>
    }

    func transform(_ input: Input) -> Output {
        
        let elements = BehaviorRelay<[DefaultSection]>(value: [])
        let noticeNoMoreData = PublishSubject<Void>()
        
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
                return self.request().trackActivity(self.headerLoading).asDriverOnErrorJustComplete()
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
            .loadMoreTrigger
            .flatMapLatest({ [weak self] () -> Driver<[Event]> in
                guard let self = self else { return Driver.just([]) }
                self.currentPage += 1
                return self.request().trackActivity(self.footerLoading).asDriverOnErrorJustComplete()
            })
            .map({ (events) -> [DefaultSection] in
                if events.isEmpty || elements.value.first?.items.count ?? 0 >= 100 { //TODO: fix Me
                    noticeNoMoreData.onNext(())
                    return elements.value
                } else {
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
        
        return Output(items: elements.asDriver(), noticeNoMoreData: noticeNoMoreData.asDriverOnErrorJustComplete())
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
