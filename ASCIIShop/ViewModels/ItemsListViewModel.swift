//
//  ItemsListViewModel.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ItemsListViewModel {
    // Is loading profile
    let isLoading: Driver<Bool>
    let items = Variable<[StockItemViewModel]>([])
    let updating = PublishSubject<Bool>()
    let inStockOnly = Variable<Bool>(false)
    let error = PublishSubject<String>()
    
    // Handle loading next page (on scroll to bottom)
    var loadNextPage: Observable<Void>! {
        didSet {
            let _isLoading = isLoadingItems
            loadNextPage
                .pausable(pauser: _isLoading.asObservable().map { !$0 })
                .filter() { self.skip != nil } // Filter if there's no more to load
                .subscribeOn(RxDependencies.shared.backgroundWorkScheduler)
                .subscribe(onNext: { [weak self] (_) in
                    self?.updateList(activity: _isLoading)
                }).addDisposableTo(disposeBag)
        }
    }
    
    // This driver represents searchbar
    var search: Driver<String>! {
        didSet {
            let _isLoading = isLoadingItems
            // Handle pull-to-refresh
            search.skip(1).drive(onNext: { [weak self] (searchString) in
                // Cancel all running fetch operation, since we're going to fetch from scratch
                self?.apiDisposeBag = DisposeBag()
                self?.skip = nil
                // We could clear old list when doing new search
                self?.items.value = []
                self?.searchTerm = searchString.count == 0 ? nil : searchString
                self?.updateList(activity: _isLoading, clean: true)
            }).addDisposableTo(disposeBag)
        }
    }
    
    // This driver represents pull-to-refresh handler
    var update: Driver<Void>! {
        didSet {
            let _isLoading = isLoadingItems
            // Handle pull-to-refresh
            update.drive(onNext: { [weak self] () in
                // Cancel all running fetch operation, since we're going to fetch from scratch
                self?.apiDisposeBag = DisposeBag()
                self?.updateList(activity: _isLoading, clean: true)
            }).addDisposableTo(disposeBag)
        }
    }
    
    fileprivate var searchTerm: String? = nil
    fileprivate var skip: Int? = nil
    fileprivate let isLoadingItems = ActivityIndicator()
    fileprivate let disposeBag = DisposeBag()
    fileprivate var apiDisposeBag = DisposeBag()
    fileprivate var service: StockItemsServiceType
    
    init(itemsService: StockItemsServiceType) {
        service = itemsService
        isLoading = isLoadingItems.asDriver()
        updateList(activity: isLoadingItems)
        
        let _isLoading = isLoadingItems
        // Why skip 2? First is initial value, second is binding. Only all subsequent changes are needed
        inStockOnly.asObservable().skip(2).subscribe(onNext: { [weak self] (inStock) in
            self?.apiDisposeBag = DisposeBag()
            self?.items.value = []
            self?.updateList(activity: _isLoading, clean: true)
        }).addDisposableTo(disposeBag)
    }
    
    fileprivate func updateList(activity: ActivityIndicator, clean: Bool = false) {
        var filter = StockItemsServiceFilter()
        filter.pattern = searchTerm
        filter.skip = skip
        filter.inStock = inStockOnly.value
        UIApplication.activity = true
        (searchTerm == nil ? service.list(filter: filter) : service.search(filter: filter))
            .trackActivity(activity)
            .observeOn(RxDependencies.shared.mainScheduler)
            .subscribe(onNext: { [weak self] (result) in
                UIApplication.activity = false
                self?.updating.onNext(false)
                result.unwrap(onSuccess: { (stockItems) in
                    print(stockItems)
                    self?.skip = stockItems.count > 0 ? ((self?.items.value.count ?? 0) + stockItems.count) : nil
                    self?.items.value = (clean ? [] : (self?.items.value ?? [])) + stockItems.map { StockItemViewModel(item: $0) }
                }, onError: { (error) in
                    print(error)
                    self?.error.onNext("Failed to load a list of items.")
                })
        }).addDisposableTo(apiDisposeBag)
    }
}
