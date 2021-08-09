//
//  UIImageView.swift
//  MovieAPP
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import UIKit
public extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
