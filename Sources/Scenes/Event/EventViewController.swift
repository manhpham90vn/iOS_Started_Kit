//
//  EventViewController.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit

final class EventViewController: BaseTableViewViewController, BindableType {
    
    // MARK: - Properties
    var viewModel: EventViewModel
    private let logOutBtn = UIBarButtonItem(title: R.string.localizable.log_out_title(), style: .plain, target: self, action: nil)
    
    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
    }
    
    // MARK: - Methods
    private func configView() {
        title = R.string.localizable.event_title()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = logOutBtn
        
        tableView.register(cellType: EventTableViewCell.self)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }

    func bindViewModel() {
                
        viewModel
            .loading
            .asDriver()
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
                
        viewModel
            .headerLoading
            .asDriver()
            .drive(isHeaderLoading)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .footerLoading
            .asDriver()
            .drive(isFooterLoading)
            .disposed(by: rx.disposeBag)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<DefaultSection>(
            configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EventTableViewCell.self)
                cell.config(title: item.actor?.login, subtitle: item.repo?.name, subDescription: item.type)
                return cell
            }
        )
        
        let input = EventViewModel.Input(loadTrigger: Driver.just(()),
                                         refreshTrigger: headerRefreshTrigger.asDriverOnErrorJustComplete(),
                                         loadMoreTrigger: footerLoadMoreTrigger.asDriverOnErrorJustComplete(),
                                         logOutTrigger: logOutBtn.rx.tap.asDriver())
        let output = viewModel.transform(input)
        
        output
            .items
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output
            .isEnableLoadMore
            .drive(isEnableLoadMore)
            .disposed(by: rx.disposeBag)
        
        output
            .toLoginTrigger
            .do(onNext: { [weak self] in
                self?.logOut()
            })
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    func logOut() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension EventViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
