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
    
    let isEnableLoadMore = BehaviorRelay(value: true)
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
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
        
        isFooterLoading
            .filter({ [weak self] _ in
                self?.isEnableLoadMore.value == true
            })
            .bind(to: isAnimatingFooter)
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
                if let isRefreshing = viewController.tableView.mj_header?.isRefreshing, !isRefreshing {
                    viewController.tableView.mj_header?.beginRefreshing()
                }
            } else {
                if let isRefreshing = viewController.tableView.mj_header?.isRefreshing, isRefreshing {
                    viewController.tableView.mj_header?.endRefreshing()
                }
            }
        }
    }

    private var isAnimatingFooter: Binder<Bool> {
        return Binder(self) { viewController, loading in
            if loading {
                if let isRefreshing = viewController.tableView.mj_footer?.isRefreshing, !isRefreshing {
                    viewController.tableView.mj_footer?.beginRefreshing()
                }
            } else {
                if let isRefreshing = viewController.tableView.mj_footer?.isRefreshing, isRefreshing {
                    viewController.tableView.mj_footer?.endRefreshing()
                }
            }
        }
    }
    
}
