//
//  BaseTableViewViewController.swift
//  MyApp
//
//  Created by Manh Pham on 3/18/20.
//

import UIKit
import MJRefresh

class BaseTableViewViewController: BaseViewController { // swiftlint:disable:this final_class

    let headerRefreshTrigger = PublishSubject<Void>()
    let footerLoadMoreTrigger = PublishSubject<Void>()
    
    let isEnableLoadMore = PublishSubject<Bool>()
    let isHeaderLoading = PublishSubject<Bool>()
    let isFooterLoading = PublishSubject<Bool>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.headerRefreshTrigger.onNext(())
        })
        isHeaderLoading.bind(to: isAnimatingHeader).disposed(by: rx.disposeBag)
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.footerLoadMoreTrigger.onNext(())
        })
        
        let isEnableAnimatingFooter = Observable.merge(isEnableLoadMore.filter({ $0 == false }),
                                                       isHeaderLoading.filter({ $0 == true }))
        Observable.combineLatest(isFooterLoading, isEnableAnimatingFooter) { value, isEnable in
            return isEnable ? value : nil
        }
        .compactMap({ $0 })
        .asDriverOnErrorJustComplete()
        .drive(isAnimatingFooter)
        .disposed(by: rx.disposeBag)
        
        isEnableLoadMore.bind(to: isEnableLoadMoreBinder).disposed(by: rx.disposeBag)
    }
    
}

extension BaseTableViewViewController {
    
    private var isEnableLoadMoreBinder: Binder<Bool> {
        return Binder(self) { viewController, enable in
            if enable {
                viewController.tableView.mj_footer?.resetNoMoreData()
            } else {
                viewController.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
    
    private var isAnimatingHeader: Binder<Bool> {
        return Binder(self) { viewController, loading in
            if loading {
                viewController.tableView.mj_header?.beginRefreshing()
            } else {
                viewController.tableView.mj_header?.endRefreshing()
            }
        }
    }

    private var isAnimatingFooter: Binder<Bool> {
        return Binder(self) { viewController, loading in
            if loading {
                viewController.tableView.mj_footer?.beginRefreshing()
            } else {
                viewController.tableView.mj_footer?.endRefreshing()
            }
        }
    }
    
}
