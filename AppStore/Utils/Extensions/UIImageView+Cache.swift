//
//  UIImageView+Cache.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-15.
//  Copyright © 2020 Heberti Almeida. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSURL, UIImage>()

extension UIImageView {
    func setImage(_ url: URL?) {
        image = nil
        guard let url = url else { return }

        if let imageFromCache = imageCache.object(forKey: url as NSURL) {
            image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }

            guard
                let data = data,
                let imageToCache = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self?.image = imageToCache
            }

            imageCache.setObject(imageToCache, forKey: url as NSURL)
        }.resume()
    }
}
