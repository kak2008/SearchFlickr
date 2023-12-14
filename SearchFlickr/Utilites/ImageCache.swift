//
//  ImageCache.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/13/23.
//

import Foundation
import UIKit

class ImageCache {
    
    static var shared = ImageCache()

    // Create a cache using a simple dictionary
    private var cache = [String: UIImage]()

    // Function to fetch an image from the cache or load it if not present
    func getImage(withUrl urlString: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        // Check if the image is already in the cache
        if let cachedImage = cache[urlString] {
            completion(cachedImage)
            return nil
        } else {
            // If not, download the image
            return downloadImage(from: urlString) { [weak self] (image) in
                guard let self = self, let image = image else {
                    completion(nil)
                    return
                }

                // Cache the downloaded image
                self.cache[urlString] = image

                // Return the image to the completion handler
                completion(image)
            }
        }
    }

    // Function to download an image from a URL
    private func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }

        task.resume()
        return task
    }
}
