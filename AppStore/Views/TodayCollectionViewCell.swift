//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit
import SnapKit
import PINRemoteImage

final class TodayCollectionViewCell: UICollectionViewCell {

    let smallLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    lazy var imageView = UIImageView(frame: bounds)

    override init(frame: CGRect) {
        super.init(frame: frame)

        let corner: CGFloat = 14
        layer.cornerRadius = corner

        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 18
        layer.shadowOpacity = 0.2
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: corner).cgPath

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = corner-1
        contentView.addSubview(imageView)

        // Labels
        smallLabel.numberOfLines = 1
        contentView.addSubview(smallLabel)

        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)

        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(descriptionLabel)

        imageView.snp.makeConstraints { make in
            make.size.equalTo(contentView)
        }

        smallLabel.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.left.right.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(smallLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(18)
            make.left.right.equalToSuperview().inset(20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(imageUrl: URL?, label: String, title: String, description: String, color: UIColor) {
        imageView.pin_setImage(from: imageUrl)

        smallLabel.attributedText = TextStyle.cardSmall(label, color: color)
        titleLabel.attributedText = TextStyle.cardTitle(title, color: color)
        descriptionLabel.attributedText = TextStyle.cardDescription(description, color: color)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.pin_cancelImageDownload()
        imageView.pin_clearImages()
    }
}
