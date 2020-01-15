//
//  TodayHeaderView.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit
import SnapKit

final class TodayHeaderView: UICollectionReusableView {

    private let dateLabel = UILabel()
    private let dayLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        dateLabel.numberOfLines = 1
        dateLabel.backgroundColor = .white
        addSubview(dayLabel)

        dayLabel.numberOfLines = 1
        dayLabel.backgroundColor = .white
        addSubview(dateLabel)

        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }

        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(3)
            make.left.right.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview().priority(.low)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(date: String, title: String) {
        dateLabel.attributedText = TextStyle.headerSmall(date)
        dayLabel.attributedText = TextStyle.headerBig(title)
    }
}