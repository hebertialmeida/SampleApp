//
//  TodayHeaderView.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit

final class TodayHeaderView: UICollectionReusableView {

    lazy var dateLabel = UILabel(frame: CGRect.zero)
    lazy var dayLabel = UILabel(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        dateLabel.numberOfLines = 1
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)

        dayLabel.numberOfLines = 1
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dayLabel)

        // Configure layout contraints
        var constraints = [NSLayoutConstraint]()
        let views: [String : Any] = [
            "dateLabel": dateLabel,
            "dayLabel": dayLabel
        ]

        NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[dateLabel]-3-[dayLabel]-0-|", options: [], metrics: nil, views: views).forEach { constraints.append($0) }
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[dateLabel]-20-|", options: [], metrics: nil, views: views).forEach { constraints.append($0) }
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[dayLabel]-20-|", options: [], metrics: nil, views: views).forEach { constraints.append($0) }

        addConstraints(constraints)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(date: String, title: String) {
        dateLabel.attributedText = TextStyle.headerSmall(date)
        dateLabel.sizeToFit()

        dayLabel.attributedText = TextStyle.headerBig(title)
        dayLabel.sizeToFit()
    }
}
