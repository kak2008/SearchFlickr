//
//  ImageCollectionViewCell.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/13/23.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "imageCollectionViewCell"
    var imageLoadingTask: URLSessionDataTask?
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // Required initializer when subclassing UICollectionViewCell
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        // Initialize and configure your UI elements here
        contentView.addSubview(imageView)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
                
        // Add constraints (customize as per your layout)
        let views = ["imageView": imageView]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", metrics: nil, views: views)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", metrics: nil, views: views)
        
        contentView.addConstraints(hConstraints)
        contentView.addConstraints(vConstraints)
    }
    
    // Function to configure the cell with data
    func configure(withImageURl urlstring: String) {
        imageLoadingTask = ImageCache.shared.getImage(withUrl: urlstring) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageLoadingTask?.cancel()
        imageLoadingTask = nil
    }
}
