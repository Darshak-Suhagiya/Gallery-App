//
//  GalleryVC + CollectionViewDelegate.swift
//  Gallery App
//
//  Created by Amul Patel on 26/01/24.
//

import Foundation
import UIKit

extension GalleryVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        if indexPath.row < images.count {
            cell.imageView.image = images[indexPath.row]
        }
        else{
            cell.imageView.isHidden = true
            if viewModel.isImagesLoading {
                cell.indecatorView.startAnimating()
                cell.loadMoreButton.isHidden = true
            }
            else {
                cell.indecatorView.stopAnimating()
                cell.loadMoreButton.isHidden = false
            }
            cell.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.width / 3)
    }
    
}
