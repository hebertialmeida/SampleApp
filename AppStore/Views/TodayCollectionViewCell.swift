//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit
import PINRemoteImage

final class TodayCollectionViewCell: UICollectionViewCell {

    lazy var smallLabel = UILabel(frame: .zero)
    lazy var titleLabel = UILabel(frame: .zero)
    lazy var descriptionLabel = UILabel(frame: .zero)
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
        addSubview(imageView)

        // Labels
        smallLabel.numberOfLines = 1
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(smallLabel)

        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)

        // Configure layout contraints
        var constraints = [NSLayoutConstraint]()
        let views: [String : Any] = [
            "smallLabel": smallLabel,
            "titleLabel": titleLabel,
            "descriptionLabel": descriptionLabel
        ]

        NSLayoutConstraint.constraints(withVisualFormat: "V:|-18-[smallLabel]-4-[titleLabel]", metrics: nil, views: views).forEach { constraints.append($0) }
        NSLayoutConstraint.constraints(withVisualFormat: "V:[descriptionLabel]-18-|", metrics: nil, views: views).forEach { constraints.append($0) }

        NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[smallLabel]-20-|", metrics: nil, views: views).forEach { constraints.append($0) }
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-20-|", metrics: nil, views: views).forEach { constraints.append($0) }
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[descriptionLabel]-20-|", metrics: nil, views: views).forEach { constraints.append($0) }

        addConstraints(constraints)
    }

    func setContent(imageUrl: URL?, label: String, title: String, description: String, color: UIColor) {
        imageView.pin_setImage(from: imageUrl)

        smallLabel.attributedText = TextStyle.cardSmall(label, color: color)
        smallLabel.sizeToFit()

        titleLabel.attributedText = TextStyle.cardTitle(title, color: color)
        titleLabel.sizeToFit()

        descriptionLabel.attributedText = TextStyle.cardDescription(description, color: color)
        descriptionLabel.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.pin_cancelImageDownload()
        imageView.pin_clearImages()
    }
}
