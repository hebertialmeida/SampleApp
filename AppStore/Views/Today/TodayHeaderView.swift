//
//  TodayHeaderView.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit

final class TodayHeaderView: UICollectionReusableView {

    static var identifier: String = "TodayHeaderView"
    private let dateLabel = UILabel()
    private let dayLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        dateLabel.numberOfLines = 1
        dateLabel.backgroundColor = .white
        addSubview(dayLabel)

        dayLabel.numberOfLines = 1
        addSubview(dateLabel)

        let space: CGFloat = 20
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: space).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: space).isActive = true

        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: space).isActive = true
        dayLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: space).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(date: String, title: String) {
        dateLabel.attributedText = TextStyle.headerSmall(date)
        dayLabel.attributedText = TextStyle.headerBig(title)
    }
}
