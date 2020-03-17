//
//  MenuViewController.swift
//  My Project
//
//  Created by Manh Pham on 3/16/20.
//  Copyright © 2020 Fujitech. All rights reserved.
//

import UIKit
import Reusable

final class MenuViewController: BaseViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: MenuViewModel

    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    // MARK: - Methods
    private func configView() {
        title = "Menu"
        navigationItem.setHidesBackButton(true, animated: false)
        
        tableView.addSubview(refreshControl)
        tableView.register(cellType: MenuTableViewCell.self)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }

    func bindViewModel() {
        
        viewModel
            .headerLoading
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .loading
            .asDriver()
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
        
        let input = MenuViewModel.Input(loadTrigger: Driver.just(()),
                                        refreshTrigger: refreshControl.rx.controlEvent(.valueChanged).asDriver(),
                                        date: AppHelper.toDayString())
        let output = viewModel.transform(input)
        
        output.items.drive(tableView.rx.items(cellIdentifier: MenuTableViewCell.reuseIdentifier,
                                              cellType: MenuTableViewCell.self)) { _, element, cell in
            cell.config(title: element.title, price: element.price)
        }
        .disposed(by: rx.disposeBag)
    }
}

extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
