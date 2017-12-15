//
//  Alamofire_ex.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import ObjectMapper

public func executeJSONRequest<T: Mappable>(urlRouter: URLRequestConvertible,
                               keyPath: String? = nil,
                               injectHandler: ((Any?) -> Void)? = nil) -> Observable<[T]?> {
    return Observable.create { observer in
        let request = Alamofire.SessionManager.default.request(urlRouter)
            .validate()
            .responseArray(queue:nil, keyPath: keyPath) { (response: DataResponse<[T]>) in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    observer.on(.next(response.result.value))
                    observer.on(.completed)
                case .failure(let error):
                    print(response)
                    print(error)
                    observer.on(.error(error))
                }
        }
        debugPrint(request)
        return Disposables.create {
            request.cancel()
        }
    }
}
