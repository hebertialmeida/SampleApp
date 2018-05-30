//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit

final class TodayCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

//        clipsToBounds = true
        let corner: CGFloat = 13
        layer.cornerRadius = corner

        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 18
        layer.shadowOpacity = 0.2
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: corner).cgPath
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
