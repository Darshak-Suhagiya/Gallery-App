//
//  ImageFetcher.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import Foundation
import Foundation
import UIKit

class ImageFetcher {
    
    private let session: URLSession
    static let shared: ImageFetcher = ImageFetcher()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache.shared
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        self.session = URLSession(configuration: configuration)
    }
    
    func fetchImages(from urls: [URL?], completion: @escaping ([UIImage]) -> Void) {
        var images: [UIImage] = []
        let group = DispatchGroup()

        for url in urls {
            group.enter()
            fetchImage(from: url) { image in
                defer { group.leave() }
                if let image = image {
                    images.append(image)
                }
            }
        }

        group.notify(queue: DispatchQueue.global()) {
            DispatchQueue.main.async {
                completion(images)
            }
        }
    }

    private func fetchImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
