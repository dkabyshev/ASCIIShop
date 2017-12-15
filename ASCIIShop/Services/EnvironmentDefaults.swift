//
//  EnvironmentDefaults.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation

struct EnvironmentDefaults {
    typealias Me = EnvironmentDefaults
    
    fileprivate static var environmentShared: NSDictionary? {
        if let path = Bundle.main.path(forResource: "environment", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }
    
    fileprivate static var environment: NSDictionary? {
        #if DEBUG
            let environment_file = "env_stage"
        #else
            let environment_file = "env_prod"
        #endif
        if let path = Bundle.main.path(forResource: environment_file, ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }
    
    /// MARK: Public variables
    static let baseAPIURLString = Me.value(forKey: "backendBaseUrl", dict: Me.environment)
}

extension EnvironmentDefaults {
    fileprivate static func value(forKey key: String, dict: NSDictionary? = Me.environmentShared) -> String {
        guard let string: String = dict?.value(forKey: key) as? String else {
            return ""
        }
        
        return string
    }
}
