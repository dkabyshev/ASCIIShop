//
//  StockItemViewModel.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class StockItemViewModel {
    let price: Variable<String>
    let face: Variable<NSAttributedString>
    
    init(item: StockItem) {
        if let price = item.price {
            self.price = Variable<String>("$\(price)") // Specs has static formating
        } else {
            self.price = Variable<String>("Not avaiable")
        }
        
        let attributes = [ NSFontAttributeName: UIFont.systemFont(ofSize: CGFloat(item.size ?? 14)) ]
        let attrString = NSAttributedString(string: item.face, attributes: attributes)
        face = Variable<NSAttributedString>(attrString)
    }
}
