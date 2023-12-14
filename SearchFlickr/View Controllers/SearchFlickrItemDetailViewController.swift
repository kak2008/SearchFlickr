//
//  SearchFlickrItemDetailViewController.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/13/23.
//

import Foundation
import UIKit

class SearchFlickrItemDetailViewController: UIViewController {
    
    var viewmodel: SearchFlickrItemDetailViewModel?
    var imageLoadingTask: URLSessionDataTask?
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nameLabel = ResizableLabels(frame: CGRect.zero, font: .preferredFont(forTextStyle: UIFont.TextStyle.headline, compatibleWith: UIScreen.main.traitCollection))
    
    private var artistLabel = ResizableLabels(frame: CGRect.zero, font: .preferredFont(forTextStyle: UIFont.TextStyle.subheadline, compatibleWith: UIScreen.main.traitCollection))
    
    private var frameInfoLabel = ResizableLabels(frame: CGRect.zero, font: .preferredFont(forTextStyle: UIFont.TextStyle.subheadline, compatibleWith: UIScreen.main.traitCollection))
    
    private var publishedDateLabel = ResizableLabels(frame: CGRect.zero, font: .preferredFont(forTextStyle: UIFont.TextStyle.subheadline, compatibleWith: UIScreen.main.traitCollection))
    
    private var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 2
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupSubViews()
        setupConstraints()
        configure()
    }
    
    func setupSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(frameInfoLabel)
        contentView.addSubview(publishedDateLabel)
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let constant20 = CGFloat(20)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant20),
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),

            nameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: constant20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: constant20),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),

            frameInfoLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: constant20),
            frameInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            frameInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            
            publishedDateLabel.topAnchor.constraint(equalTo: frameInfoLabel.bottomAnchor, constant: constant20),
            publishedDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant20),
            publishedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant20),
            publishedDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant20)
        ])
    }
    
    func configure() {
        guard let viewmodel = viewmodel else { return }
        let imageUrl = viewmodel.flickrItem.media.m
        
        imageLoadingTask = ImageCache.shared.getImage(withUrl: imageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.albumImageView.image = image
            }
        }
        
        nameLabel.text = viewmodel.title
        artistLabel.text = viewmodel.authorName
        frameInfoLabel.text = viewmodel.imageFrameInfo(image: self.albumImageView.image)
        publishedDateLabel.text = viewmodel.publishedDate
    }
}
