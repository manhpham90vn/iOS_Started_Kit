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
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<DefaultSection>(
            configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MenuTableViewCell.self)
                cell.config(title: item.actor?.login, subtitle: item.repo?.name, subDescription: item.type)
                return cell
            }
        )
        
        let input = MenuViewModel.Input(loadTrigger: Driver.just(()),
                                        refreshTrigger: refreshControl.rx.controlEvent(.valueChanged).asDriver())
        let output = viewModel.transform(input)
        
        output
            .items
            .map { (meals) -> [DefaultSection] in
                return [DefaultSection(id: 1, items: meals)]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
