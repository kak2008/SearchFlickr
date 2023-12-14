//
//  SearchFlickrItemDetailViewModelTests.swift
//  SearchFlickrTests
//
//  Created by Anish Kodeboyina on 12/13/23.
//

import XCTest
@testable import SearchFlickr

final class SearchFlickrItemDetailViewModelTests: XCTestCase {

    var viewModel: SearchFlickrItemDetailViewModel!
    
    override func setUpWithError() throws {
        let item = Item(title: "firstTitle", link: "", media: Media(m: "testMedia"), dateTaken: "", description: "", published: "", author: "John", authorID: "", tags: "")
        viewModel = SearchFlickrItemDetailViewModel(flickrItem: item)
    }

    func testData() throws {
        XCTAssertEqual(viewModel.title, "Title: firstTitle")
        XCTAssertEqual(viewModel.authorName, "Author: John")
        XCTAssertEqual(viewModel.publishedDate, "")
        let uiimage = UIImage(systemName: "Pen")
        XCTAssertEqual(viewModel.imageFrameInfo(image: uiimage), "Width: 0.0 \n Height: 0.0")
    }
}
