//
//  ViewController.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import UIKit
import Rswift
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    @IBOutlet weak var inStockSwitch: UISwitch!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    fileprivate let disposeBag = DisposeBag()
    fileprivate var viewModel: ItemsListViewModel!
    fileprivate var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, StockItemViewModel>>()
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var activityView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(R.nib.itemStockCell(), forCellReuseIdentifier: R.reuseIdentifier.itemCell.identifier)
        tableView.addSubview(refreshControl)
        tableView.rowHeight = 200
        tableView.tableFooterView = UIView()
        
        // Ideally should be created elsewhere
        viewModel = ItemsListViewModel(itemsService: StockItemsService())
        
        // --- Re-fetch the list based on inStockOnly flag
        (inStockSwitch.rx.value <-> viewModel.inStockOnly).addDisposableTo(disposeBag)
        // ---
        
        // --- Search binding
        viewModel.search = searchBar.rx.text.orEmpty.asDriver()
            .throttle(1)
            .distinctUntilChanged()
        // --- 
        
        // --- Scroll to bottom + load next page
        viewModel.loadNextPage = tableView.rx.contentOffset
            .flatMap { _ in
                self.tableView.isNearBottomEdge(edgeOffset: 20.0)
                    ? Observable.just(())
                    : Observable.empty()
        }
        // ---
        // --- Pull to refresh
        viewModel.update = refreshControl.rx.controlEvent(.valueChanged).asDriver()
        viewModel.updating.bindTo(refreshControl.rx.refreshing).addDisposableTo(disposeBag)
        // ---
        // --- Activity indicator at bottom
        activityView = LoadingView.create(height: 40)
        activityView?.activityIndicator.startAnimating()
        viewModel.isLoading.drive(onNext: { [weak self] (isLoading) in
            self?.tableView.tableFooterView = isLoading ? self?.activityView : UIView()
        }).addDisposableTo(disposeBag)
        // ---
        
        
        // --- Configure cells and bind items
        dataSource.configureCell = { (_, tv, ip, item: StockItemViewModel) in
            let cell = tv.dequeueReusableCell(withIdentifier: R.reuseIdentifier.itemCell.identifier) as? ItemTableViewCell
            cell?.viewModel = item
            return cell!
        }
        viewModel.items.asDriver()
            .map { [SectionModel(model: "", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        // ---
        
        // --- Report error
        viewModel.error.observeOn(RxDependencies.shared.mainScheduler)
        .subscribe(onNext: { [weak self] (message) in
            let dialog = UIAlertController(title: "Error",
                                           message: message,
                                           preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .default) { action -> Void in
            }
            dialog.addAction(okButton)
            self?.present(dialog, animated: true, completion: nil)
        }).addDisposableTo(disposeBag)
        // ---
    }

}

