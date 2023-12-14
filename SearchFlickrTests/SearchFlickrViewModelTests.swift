//
//  SearchFlickrTests.swift
//  SearchFlickrTests
//
//  Created by Anish Kodeboyina on 12/12/23.
//

import XCTest
@testable import SearchFlickr

final class SearchFlickrViewModelTests: XCTestCase, FlickrImageDataDelegate {
    var viewModel: SearchFlickrViewModel!
    
    override func setUpWithError() throws {
        viewModel = SearchFlickrViewModel(flickrImageDataDelegate: self)
    }

    func testNumberOfCells() throws {
        // With No data
        XCTAssertEqual(viewModel.numberOfCells, 0)
        
        // With 1 item in data
        let items = Item(title: "firstTitle", link: "", media: Media(m: "testMedia"), dateTaken: "", description: "", published: "", author: "John", authorID: "", tags: "")
        viewModel.flickrData = FlickrData(title: "TestTitl", link: "testlink", description: "TestDescriptiob", modified: "", generator: "", items: [items])
        XCTAssertEqual(viewModel.numberOfCells, 1)
    }
    
    func testgetImageUrlString() throws {
        // With No data
        XCTAssertEqual(viewModel.getImageUrlString(for: IndexPath(row: 0, section: 0)), "")
        
        let items = Item(title: "firstTitle", link: "", media: Media(m: "testMedia"), dateTaken: "", description: "", published: "", author: "John", authorID: "", tags: "")
        viewModel.flickrData = FlickrData(title: "TestTitl", link: "testlink", description: "TestDescriptiob", modified: "", generator: "", items: [items])
        XCTAssertEqual(viewModel.getImageUrlString(for: IndexPath(row: 0, section: 0)), "testMedia")
    }
    
    func didfetchFlickrData() {
        print("delegate called")
    }
}
