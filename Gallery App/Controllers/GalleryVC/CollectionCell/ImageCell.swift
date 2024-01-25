//
//  ImageCell.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import UIKit

protocol ImageCellDelegate {
    func didLoadMorePressed()
}

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadMoreButton: UIButton!
    @IBOutlet weak var indecatorView: UIActivityIndicatorView!
    
    var delegate: ImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    @IBAction func onLoadMore(_ sender: Any) {
        indecatorView.startAnimating()
        loadMoreButton.isHidden = true
        delegate?.didLoadMorePressed()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.isHidden = false
        loadMoreButton.isHidden = true
        indecatorView.stopAnimating()
    }
    
}
