//
//  ItemTableViewCell.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import UIKit
import RxSwift

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var internalView: UIView!

    fileprivate var diposeBag = DisposeBag()
    var viewModel: StockItemViewModel! {
        didSet {
            viewModel.face.asDriver().drive(itemDescription.rx.attributedText).addDisposableTo(diposeBag)
            viewModel.price.asDriver().drive(price.rx.text).addDisposableTo(diposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        internalView.layer.cornerRadius = 5
        internalView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        diposeBag = DisposeBag()
    }
}
