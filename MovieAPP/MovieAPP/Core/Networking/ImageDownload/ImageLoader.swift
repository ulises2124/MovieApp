//
//  ImageLoader.swift
//  MovieAPP
//
//  Created by Ulises Gonzalez on 08/08/21.
//
import UIKit
class ImageLoader {
    private var runningRequests = [UUID: URLSessionDataTask]()
    let cache = NSCache<NSString, UIImage>()
    func loadImage(_ url: URL, _ completion: @escaping (Results<UIImage, Error>) -> Void) -> UUID? {
        let uuid = UUID()
        // Validate if image existing in cache for use
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(.success(image))
        } else {
            // if not download image and store in cache
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                defer {self.runningRequests.removeValue(forKey: uuid) }
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(.success(image))
                    return
                }
                guard let error = error else {
                    return
                }
                guard (error as NSError).code == NSURLErrorCancelled else {
                    completion(.failure(error))
                    return
                }
            }
            task.resume()
            runningRequests[uuid] = task
        }
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}

@frozen
public enum Results<Success: UIImage, Failure: Error> {
    case success(Success)
    case failure(Failure)
}
