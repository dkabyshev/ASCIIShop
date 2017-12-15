//
//  LoadingView.swift
//  ASCIIShop
//
//  Created by Dmytro Kabyshev on 11/24/16.
//  Copyright © 2016 Dmytro Kabyshev. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    var contentView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static func create(height: Int) -> LoadingView {
        return LoadingView(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        contentView = R.nib.loadingView.firstView(owner: self)
        guard let content = contentView else { return }
        
        contentView.backgroundColor = UIColor.clear
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backgroundColor = UIColor.clear
        addSubview(content)
        activityIndicator.hidesWhenStopped = true
    }
}
