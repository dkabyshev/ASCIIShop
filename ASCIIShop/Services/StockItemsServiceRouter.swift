//
//  StockItemsServiceRouter.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import Alamofire

enum StockItemsServiceRouter: URLRequestConvertible {
    case list(Bool, Int?, Int?) // onlyInStock, skip, limit
    case search(Bool, String, Int?, Int?) // onlyInStock, search, skip, limit
    
    var method: HTTPMethod {
        switch self {
        case .list, .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .list:
            return "/products"
        case .search:
            return "/search"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .list(onlyInStock, skip, limit):
            var params: [String: Any] = ["onlyInStock": onlyInStock]
            if let skip = skip {
                params["skip"] = skip
            }
            if let limit = limit {
                params["limit"] = limit
            }
            return params
        case let .search(onlyInStock, string, skip, limit):
            var params: [String: Any] = ["onlyInStock": onlyInStock,
                                         "q": string]
            if let skip = skip {
                params["skip"] = skip
            }
            if let limit = limit {
                params["limit"] = limit
            }
            return params
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .list, .search:
            return URLEncoding.queryString
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try EnvironmentDefaults.baseAPIURLString.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
