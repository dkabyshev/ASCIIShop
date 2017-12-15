//
//  StockItemsType.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import RxSwift

typealias ItemsListResult = DataServiceResult<[StockItem], ApiError>

struct StockItemsServiceFilter {
    var limit: Int = 15
    var skip: Int? = nil
    var pattern: String? = nil
    var inStock: Bool = false
}

protocol StockItemsServiceType {
    /// Fetch a list of stock items with paginaton
    ///
    /// - Parameter filter: Filter to be applied. Only skip, limit & inStock are used.
    /// - Returns: An array of StockItem in case of success. ApiError otherwise
    func list(filter: StockItemsServiceFilter) -> Observable<ItemsListResult>
    
    /// Search for an item in stock by a filter provided.
    ///
    /// - Parameter filter: Filter to be applied.
    /// - Returns: An array of StockItem in case of success. ApiError otherwise
    func search(filter: StockItemsServiceFilter) -> Observable<ItemsListResult>
}
