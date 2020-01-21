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
                let imageToCache = UIImage(data: data),
                let decodedImage = self?.decodedImage(imageToCache)?.cgImage
            else {
                return
            }

            DispatchQueue.main.async {
                self?.image = UIImage(cgImage: decodedImage)
            }

            imageCache.setObject(imageToCache, forKey: url as NSURL)
        }.resume()
    }

    // Decode image off the main thread
    private func decodedImage(_ image: UIImage) -> UIImage? {
      guard let newImage = image.cgImage else { return nil }

      let colorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: nil, width: newImage.width, height: newImage.height, bitsPerComponent: 8, bytesPerRow: newImage.width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
      let drawnImage = context?.makeImage()

      if let drawnImage = drawnImage {
        return UIImage(cgImage: drawnImage)
      }
      return nil
    }
}
