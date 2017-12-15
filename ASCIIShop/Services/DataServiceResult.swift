//
//  DataServiceResult.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case notImplemented
    case serverError(String)
}

protocol ErrorObservable {
    var error: Error? { get }
}

/**
 This enum represents generic return type of async network request.
 In case of success *value* will return raw data returned by service.
 Otherwise it should indicate an error.
 */
public enum DataServiceResult<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    internal var error: Error? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    func unwrap(onSuccess: ((T) -> ())?, onError: ((Error) -> ())?) {
        switch self {
        case let .success(result):
            onSuccess?(result)
        case let .failure(error):
            onError?(error)
        }
    }
}
