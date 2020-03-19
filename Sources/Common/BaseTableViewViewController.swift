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

    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
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
        isFooterLoading.bind(to: isAnimatingFooter).disposed(by: rx.disposeBag)
        
    }
    
}
