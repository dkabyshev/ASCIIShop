//
//  CustomCache.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation

class CustomURLCache: URLCache {
    // UserInfo expires key
    fileprivate let urlCacheExpiresKey = "urlCacheExpiresKey"
    // How long is cache data valid
    var cacheExpireInterval: TimeInterval = 0
    
    convenience init(memoryCapacity: Int, diskCapacity: Int, expireInterval: TimeInterval) {
        self.init(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: nil)
        self.cacheExpireInterval = expireInterval
    }
    
    // get cache response for a request
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        // try to get cache response
        guard let cachedResponse = super.cachedResponse(for: request),
            let userInfo = cachedResponse.userInfo,
            let cacheDate = userInfo[urlCacheExpiresKey] as? Date else { return nil }
        
        // check if the cache data are expired
        if cacheDate.timeIntervalSinceNow < -cacheExpireInterval {
            // remove old cache request
            self.removeCachedResponse(for: request)
            return nil
        }
        
        return cachedResponse
    }
    
    // store cached response
    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        // create userInfo dictionary
        var userInfo: [AnyHashable: Any] = [:]
        if let cachedUserInfo = cachedResponse.userInfo {
            userInfo = cachedUserInfo
        }
        // add current date to the UserInfo
        userInfo[urlCacheExpiresKey] = Date()
        
        // create new cached response
        let newCachedResponse = CachedURLResponse(response: cachedResponse.response,
                                                  data: cachedResponse.data,
                                                  userInfo: userInfo,
                                                  storagePolicy: cachedResponse.storagePolicy)
        super.storeCachedResponse(newCachedResponse, for: request)
    }
}
