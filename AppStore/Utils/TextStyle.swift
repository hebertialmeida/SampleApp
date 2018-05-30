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

    // MARK: Card

    static func cardSmall(_ string: String, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15),
            .foregroundColor: color.withAlphaComponent(0.7),
            .kern: 0.3 as AnyObject
        ]
        return NSMutableAttributedString(string: string, attributes: attributes)
    }

    static func cardTitle(_ string: String, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: 27, weight: .bold),
            .foregroundColor: color,
            .kern: 0.5 as AnyObject
        ]
        return NSMutableAttributedString(string: string, attributes: attributes)
    }

    static func cardDescription(_ string: String, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: color,
            .kern: 0.3 as AnyObject
        ]
        return NSMutableAttributedString(string: string, attributes: attributes)
    }
}
