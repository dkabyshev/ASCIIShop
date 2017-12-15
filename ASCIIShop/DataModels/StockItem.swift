//
//  StockItem.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import ObjectMapper

struct StockItem: Mappable {
    var itemId: String!
    var price: Double?
    var face: String!
    var size: Int?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        itemId   <- map["id"]
        price    <- map["price"]
        face     <- map["face"]
        size     <- map["size"]
    }
}
