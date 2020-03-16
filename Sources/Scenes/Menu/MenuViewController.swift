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
    var viewModel: MenuViewModel!

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
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
        
        viewModel
            .headerLoading
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .loading
            .asDriver()
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
    }

    func bindViewModel() {
        
        let trigger = Observable.merge(rx.viewWillAppear.mapToVoid(),
                                       refreshControl.rx.controlEvent(.valueChanged).asObservable())
        let input = MenuViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete(),
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
