//
//  StockItemsService.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import RxSwift

final class StockItemsService: StockItemsServiceType {
    /// Fetch a list of stock items with paginaton
    ///
    /// - Parameter filter: Filter to be applied. Only skip, limit & inStock are used.
    /// - Returns: An array of StockItem in case of success. ApiError otherwise
    func list(filter: StockItemsServiceFilter) -> Observable<ItemsListResult> {
        let router = StockItemsServiceRouter.list(filter.inStock, filter.skip, filter.limit)
        return (executeJSONRequest(urlRouter: router) as Observable<[StockItem]?>)
            .flatMap { (items) -> Observable<ItemsListResult> in
                guard let items = items else {
                    return Observable<ItemsListResult>.just(.failure(.serverError("Unexpected error")))
                }
                return Observable.just(.success(items))
        }
    }
    
    /// Search for an item in stock by a filter provided.
    ///
    /// - Parameter filter: Filter to be applied.
    /// - Returns: An array of StockItem in case of success. ApiError otherwise
    func search(filter: StockItemsServiceFilter) -> Observable<ItemsListResult> {
        let router = StockItemsServiceRouter.search(filter.inStock, filter.pattern ?? "", filter.skip, filter.limit)
        return (executeJSONRequest(urlRouter: router) as Observable<[StockItem]?>)
            .flatMap { (items) -> Observable<ItemsListResult> in
                guard let items = items else {
                    return Observable<ItemsListResult>.just(.failure(.serverError("Unexpected error")))
                }
                return Observable.just(.success(items))
        }
    }
}
