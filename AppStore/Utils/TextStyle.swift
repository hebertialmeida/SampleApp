//
//  TextStyle.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit

struct TextStyle {

    static func headerSmall(_ string: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 13),
            .foregroundColor: UIColor(white: 0, alpha: 0.4)
        ]
        return NSMutableAttributedString(string: string, attributes: attributes)
    }

    static func headerBig(_ string: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: 34, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        return NSMutableAttributedString(string: string, attributes: attributes)
    }
}
