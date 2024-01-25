//
//  GalleryVM.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import Foundation
import UIKit
import SDWebImage

protocol GalleryVMDelegate {
    func didImageChanges(images: [UIImage])
    func didErrorDisplay(string:String)
}

class GalleryVM: NSObject {
    
    var perPageImages:Int = 20
    var isImagesLoading:Bool = false
    var delegate: GalleryVMDelegate?
    var images:[UIImage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.isImagesLoading = false
                self.delegate?.didImageChanges(images: self.images)
            }
        }
    }
    
    var localImages:[UIImage] = [] {
        didSet {
            if localImages.count > 0 {
                images.append(contentsOf: localImages)
            }
            else {
                loadMoreImages()
                delegate?.didImageChanges(images: images)
            }
        }
    }
    
    // loading local images from coredata
    func loadLocalData() {
        isImagesLoading = true
        DispatchQueue.global().async {
            self.localImages = CoreDataManager.shared.fetchImages()
        }
    }
    
    // fetching random images from internet
    func loadMoreImages() {
        isImagesLoading = true
        ServiceManager.shared.apiCall(
            apiURL: API.baseAPI,
            parameters: [API.Key.page:Int.random(in: 1...399).description,
                         API.Key.perPage:perPageImages.description],
            headers: [API.Key.authorization:API.APIToken]) { data, error in
            if let error = error {
                self.isImagesLoading = false
                self.delegate?.didErrorDisplay(string: error)
            }
            else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(Images.self, from: data)
                    let photos = responseData.photos
                    let urls = photos.map({ $0.src.mediumURL()})
                    
                    ImageFetcher.shared.fetchImages(from: urls) { images in
                        // Handle the array of UIImage objects
                        CoreDataManager.shared.saveImages(images: images)
                        self.images.append(contentsOf: images)
                    }
                } catch {
                    self.isImagesLoading = false
                    self.delegate?.didErrorDisplay(string: "Failed to decode respose data")
                }
            }
        }
    }
}
