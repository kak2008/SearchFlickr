//
//  SearchFlickrItemDetailViewModel.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/13/23.
//

import Foundation
import UIKit

class SearchFlickrItemDetailViewModel {
    var flickrItem: Item
    
    init(flickrItem: Item) {
        self.flickrItem = flickrItem
    }
    
    var title: String {
        "Title: \(flickrItem.title)"
    }
    
    var authorName: String {
        "Author: \(flickrItem.author)"
    }
    
    var publishedDate: String {
        guard let date = flickrItem.published.formatDateString() else { return "" }
        return "Published: \(date)"
    }
    
    func imageFrameInfo(image: UIImage?) -> String {
        "Width: \(image?.size.width ?? 0) \n Height: \(image?.size.height ?? 0)"
    }
}
