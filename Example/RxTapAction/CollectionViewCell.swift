//
//  CollectionViewCell.swift
//  RxTapAction_Example
//
//  Created by Meng Li on 2019/05/07.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Reusable

class CollectionViewCell: UICollectionViewCell, Reusable {
    
    private lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String? {
        didSet {
            guard let title = title else {
                return
            }
            titleLabel.text = title
        }
    }
    
}
