//
//  SearchFlickrViewController.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/12/23.
//

import Foundation
import UIKit

class SearchFlickrViewController: UIViewController {
    
    var searchViewController: UISearchController?
    var searchViewModel: SearchFlickrViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        fetchData()
        setupSearchView()
        setupCollectionView()
        setupSlider()
    }

    func fetchData() {
        searchViewModel = SearchFlickrViewModel(flickrImageDataDelegate: self)
        searchViewModel?.getFlickrImageData()
    }
    
    func setupSearchView() {
        searchViewController = UISearchController()
        guard let searchViewController = searchViewController else { return }
        searchViewController.searchResultsUpdater = self
        searchViewController.obscuresBackgroundDuringPresentation = false
        searchViewController.searchBar.placeholder = "search"
        definesPresentationContext = true
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    func setupSlider() {
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = 3
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc
    func sliderValueChanged() {
        collectionView.reloadData()
    }
}

extension SearchFlickrViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
           return
        }
        searchViewModel?.getFlickrImageData(userEntry: text)
    }
}

extension SearchFlickrViewController: FlickrImageDataDelegate {
    func didfetchFlickrData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchFlickrViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchViewModel?.numberOfCells ??  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell, let searchViewModel =  searchViewModel else {
            return UICollectionViewCell()
        }
        
        // Configure the cell with data
        cell.configure(withImageURl: searchViewModel.getImageUrlString(for: indexPath))
        
        return cell
    }
}

extension SearchFlickrViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width
        let noOfColumns = CGFloat(Int(slider.value))
        width = width - sectionInsets().left - sectionInsets().right
        width = width - interItemSpacing() * (noOfColumns - 1)
        width = floor(width/noOfColumns)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        interItemSpacing()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        interItemSpacing()
    }
    
    func interItemSpacing() -> CGFloat {
        10
    }
    
    func sectionInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            self.collectionView.reloadData()
        }
    }
}

extension SearchFlickrViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = searchViewModel?.flickrData?.items[indexPath.row] else { return }
        let destinationViewController = SearchFlickrItemDetailViewController()
        destinationViewController.viewmodel = SearchFlickrItemDetailViewModel(flickrItem: item)
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
