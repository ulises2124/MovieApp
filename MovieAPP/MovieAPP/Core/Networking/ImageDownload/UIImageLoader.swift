//
//  UIImageLoader.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 08/08/21.
//

import UIKit
class UIImageLoader {
    static let loader = UIImageLoader()
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
        let token = imageLoader.loadImage(url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                case.failure(let error):
                    print("Error", error)
                }
            }
        }
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
