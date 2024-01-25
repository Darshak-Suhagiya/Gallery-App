//
//  GalleryVC.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import UIKit

class GalleryVC: UIViewController {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var viewModel = GalleryVM()
    var images:[UIImage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.galleryCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.loadLocalData()
        
        galleryCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
    @IBAction func onTouchUProfile(_ sender: Any) {
        let profileVC = ProfilePageVC(nibName: "ProfilePageVC", bundle: nil)
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

//MARK: Gallery Viewmodel Delegate
extension GalleryVC: GalleryVMDelegate {
    func didImageChanges(images: [UIImage]) {
        self.images = images
    }
    
    func didErrorDisplay(string: String) {
        alertTheUser(self, string: string)
    }
}

//MARK: CollectionCell Delegate
extension GalleryVC: ImageCellDelegate {
    func didLoadMorePressed() {
        viewModel.loadMoreImages()
    }
}
